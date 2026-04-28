import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/tag_entity.dart';
import 'package:vitameal/domain/entity/eats_entity.dart';

part 'eats_view_model.freezed.dart';
part 'eats_view_model.g.dart';

/// 권한 상태
enum PermissionState { loading, granted, denied, deniedForever }

/// State
@freezed
abstract class EatsState with _$EatsState {
  const factory EatsState({
    required List<EatsEntity> eats, // 음식점 리스트
    LatLng? location, // 지도 위치
    required bool loading, // 로딩중 여부
    required int selected, // 선택된 음식점
    TagEntity? selectedTag, // 선택된 태그
    required bool needSearch, // 재검색 필요 여부
    required PermissionState permission, // 권한 상태
  }) = _EatsState;
}

/// ViewModel
@riverpod
class EatsViewModel extends _$EatsViewModel {
  GoogleMapController? mapController;
  ScrollController? itemScrollController;
  ItemScrollController? tagScrollController;
  BitmapDescriptor? marker;
  BitmapDescriptor? selectedMarker;

  LatLng? _lastCenter;
  bool _isFirstMove = true;
  bool _isRequestingPermission = false;

  @override
  EatsState build() {
    return EatsState(
      eats: [],
      location: null,
      loading: true,
      selected: -1,
      selectedTag: null,
      needSearch: false,
      permission: PermissionState.loading,
    );
  }

  /// 0. 초기화
  Future<void> init() async {
    // 지도 마커 아이콘 로드
    await loadMarkerIcons();
    // 권한 확인
    await checkPermission();
    // 현재 위치 정보 가져오기
    final pos = await safeGetCurrentLocation();
    if (pos == null) {
      state = state.copyWith(loading: false);
      return;
    }
    final loc = LatLng(pos.latitude, pos.longitude);
    state = state.copyWith(location: loc, loading: true);
    // 음식점 불러오기
    await fetch(location: loc);
  }

  /// 1. 지도 마커 아이콘 불러오기
  Future<void> loadMarkerIcons() async {
    marker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(22, 28)),
      'assets/images/map_secondary.png',
    );
    selectedMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(22, 28)),
      'assets/images/map_primary.png',
    );
  }

  /// 2. 권한 확인
  Future<void> checkPermission() async {
    if (_isRequestingPermission) return;
    _isRequestingPermission = true;

    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final result = await Geolocator.requestPermission();
        if (result == LocationPermission.denied) {
          state = state.copyWith(
            permission: PermissionState.denied,
            loading: false,
          );
          return;
        }
        if (result == LocationPermission.deniedForever) {
          state = state.copyWith(
            permission: PermissionState.deniedForever,
            loading: false,
          );
          return;
        }
      }
      final finalPermission = await Geolocator.checkPermission();
      if (finalPermission == LocationPermission.deniedForever) {
        state = state.copyWith(
          permission: PermissionState.deniedForever,
          loading: false,
        );
        return;
      }
      state = state.copyWith(permission: PermissionState.granted);
    } finally {
      _isRequestingPermission = false;
    }
  }

  /// 3. 현재 위치 정보 가져오기
  Future<Position?> safeGetCurrentLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null; // 절대 throw 금지
    }
  }

  /// 4. 음식점 불러오기
  Future<void> fetch({LatLng? location}) async {
    final repo = ref.read(eatsRepositoryProvider);
    final fetchLocation = location ?? state.location;
    if (fetchLocation == null) return;

    try {
      final tagId = state.selectedTag?.id;
      final list = await repo.fetch(
        lat: fetchLocation.latitude,
        lng: fetchLocation.longitude,
        tagId: tagId,
      );
      state = state.copyWith(eats: list, loading: false);
    } catch (e) {
      debugPrint("ERROR: $e");
      state = state.copyWith(loading: false);
    }
  }

  /// 5. 태그 변경
  void changeTag(TagEntity tag, int index) {
    state = state.copyWith(
      selectedTag: tag,
      loading: true,
      needSearch: false,
      location: _lastCenter ?? state.location,
    );
    // 태그 스크롤 이동
    tagScrollController?.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 300),
      alignment: 0.1, // 위치
    );
    // 지도 중심 위치 기준 fetch
    fetch(location: _lastCenter ?? state.location);
  }

  /// 6. 내 위치로 돌아오기
  Future<void> moveToMyLocation() async {
    final pos = await safeGetCurrentLocation();
    if (pos == null) return;
    final loc = LatLng(pos.latitude, pos.longitude);
    // 지도 이동
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 14)),
    );
    _lastCenter = loc;
    state = state.copyWith(location: loc, selected: -1, needSearch: true);
  }

  /// 7. 지도 이동 시
  void onCameraMove(LatLng center) {
    _lastCenter = center;
    // 첫 렌더링 때는 무시
    if (_isFirstMove) {
      _isFirstMove = false;
      return;
    }
    // 이동 거리 기준 (재검색 버튼 띄우기용)
    final distance = Geolocator.distanceBetween(
      state.location!.latitude,
      state.location!.longitude,
      center.latitude,
      center.longitude,
    );
    if (distance > 1000) {
      state = state.copyWith(needSearch: true);
    }
  }

  /// 8. 현재 지도 위치에서 재검색
  Future<void> searchHere() async {
    if (_lastCenter == null) return;
    state = state.copyWith(
      loading: true,
      needSearch: false,
      location: _lastCenter, // 검색 기준 위치 업데이트
    );
    fetch(location: _lastCenter);
  }

  /// 9. 음식점 선택
  void select(int i) {
    state = state.copyWith(selected: i);
    final r = state.eats[i];
    mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(r.lat, r.lng)));
    // 리스트 스크롤 이동
    itemScrollController?.animateTo(
      i * 80, // 아이템 높이에 맞게 조절
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 10. 지도 스타일 변경 (라이트/다크 모드)
  Future<void> applyMapStyle(BuildContext context) async {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final style = await DefaultAssetBundle.of(context).loadString(
      isDark ? 'assets/json/map_dark.json' : 'assets/json/map_light.json',
    );
    mapController?.setMapStyle(style);
  }
}
