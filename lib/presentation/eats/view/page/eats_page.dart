import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/tag_entity.dart';
import 'package:vitameal/presentation/eats/view_model/step_view_model.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/eats/view/widget/no_permission_view.dart';
import 'package:vitameal/presentation/eats/view/widget/step_card.dart';
import 'package:vitameal/presentation/eats/view_model/eats_view_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';

class EatsPage extends ConsumerStatefulWidget {
  const EatsPage({super.key});

  @override
  ConsumerState<EatsPage> createState() => _EatsPageState();
}

class _EatsPageState extends ConsumerState<EatsPage> {
  final _itemScrollController = ScrollController();
  final _tagScrollController = ItemScrollController();

  // 태그 불러오기
  Future<List<TagEntity>> _loadTags() async {
    final locale =
        ref.read(localeViewModelProvider) ??
        WidgetsBinding.instance.platformDispatcher.locale;
    final isKo = locale.languageCode == 'ko';
    final tags = await ref.read(allTagsProvider.future);
    final sorted = [...tags]
      ..sort(
        (a, b) =>
            isKo ? a.name.compareTo(b.name) : a.nameEn.compareTo(b.nameEn),
      );
    return sorted;
  }

  @override
  void initState() {
    super.initState();
    final eatsVM = ref.read(eatsViewModelProvider.notifier);
    eatsVM.itemScrollController = _itemScrollController;
    eatsVM.tagScrollController = _tagScrollController;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(eatsViewModelProvider.notifier).applyMapStyle(context);
  }

  @override
  Widget build(BuildContext context) {
    final v = vrc(context);
    final f = fxc(context);
    final locale =
        ref.watch(localeViewModelProvider) ?? Localizations.localeOf(context);
    final state = ref.watch(eatsViewModelProvider);
    final vm = ref.read(eatsViewModelProvider.notifier);

    // 권한 없을 때 화면
    if (state.permission == PermissionState.loading ||
        state.permission == PermissionState.denied ||
        state.permission == PermissionState.deniedForever) {
      return const NoPermissionView();
    }

    // 현재 위치 불러올 수 없을 때 화면
    if (state.location == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            /// 만보기
            const StepCard(),

            Expanded(
              child: Stack(
                children: [
                  if (state.loading) Center(child: CircularProgressIndicator()),

                  /// 지도
                  GoogleMap(
                    padding: const EdgeInsets.only(left: 6, bottom: 2),
                    myLocationEnabled:
                        state.permission == PermissionState.granted,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    mapToolbarEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: state.location!,
                      zoom: 14,
                    ),
                    onMapCreated: (c) async {
                      vm.mapController = c;
                      await vm.applyMapStyle(context);
                    },
                    onCameraMove: (pos) => vm.onCameraMove(pos.target),
                    markers: state.eats.asMap().entries.map((e) {
                      final i = e.key;
                      final r = e.value;
                      final isSelected = i == state.selected;

                      return Marker(
                        markerId: MarkerId(r.name),
                        position: LatLng(r.lat, r.lng),
                        icon: isSelected
                            ? (vm.selectedMarker ??
                                  BitmapDescriptor.defaultMarker)
                            : (vm.marker ?? BitmapDescriptor.defaultMarker),
                        onTap: () => vm.select(i),
                      );
                    }).toSet(),
                  ),

                  /// 태그
                  FutureBuilder<List<TagEntity>>(
                    future: _loadTags(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const SizedBox();
                      final tags = snapshot.data!;

                      return Positioned(
                        top: 10,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 34,
                          child: ScrollablePositionedList.builder(
                            scrollDirection: Axis.horizontal,
                            itemScrollController: _tagScrollController,
                            itemCount: tags.length,
                            itemBuilder: (context, index) {
                              final tag = tags[index];
                              final selected = tag.id == state.selectedTag?.id;
                              final isFirst = index == 0;
                              final isLast = index == tags.length - 1;

                              return Padding(
                                padding: EdgeInsets.only(
                                  left: isFirst ? 12 : 0, // 첫번째 아이템만 좌측패딩 12
                                  right: isLast ? 12 : 8, // 마지막 아이템만 우측패딩 12
                                ),
                                child: ChoiceChip(
                                  label: Text(
                                    locale == Locale('ko')
                                        ? tag.name
                                        : tag.nameEn,
                                  ),
                                  selected: selected,
                                  onSelected: (_) => vm.changeTag(tag, index),
                                  showCheckmark: false,
                                  labelStyle: TextStyle(
                                    color: selected
                                        ? f.primary500
                                        : f.primary400,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  selectedColor: f.primary200,
                                  backgroundColor: v.background,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: selected
                                          ? f.primary500!
                                          : f.primary400!,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  /// 내 위치로 돌아오기 버튼
                  Positioned(
                    top: 50,
                    right: 0,
                    child: ElevatedButton(
                      onPressed: () => vm.moveToMyLocation(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: v.background,
                        elevation: 4,
                        shape: const CircleBorder(),
                      ),
                      child: PhosphorIcon(
                        PhosphorIconsFill.gpsFix,
                        color: v.text,
                      ),
                    ),
                  ),

                  /// 현재 위치에서 재검색 버튼
                  if (state.needSearch)
                    Positioned(
                      top: 100,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () => vm.searchHere(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: v.background,
                          elevation: 4,
                          shape: const CircleBorder(),
                        ),
                        child: PhosphorIcon(
                          PhosphorIcons.arrowCounterClockwise(),
                          color: v.text,
                        ),
                      ),
                    ),

                  /// 음식점 목록 Bottom sheet
                  IgnorePointer(
                    ignoring: state.eats.isEmpty,
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      minChildSize: 0.3,
                      maxChildSize: 0.3,
                      builder: (context, scroll) {
                        return ListView.builder(
                          controller: _itemScrollController,
                          itemCount: state.eats.length,
                          itemBuilder: (context, i) {
                            final r = state.eats[i];
                            final itemSelected = state.selected == i;

                            return GestureDetector(
                              onTap: () => vm.select(i),
                              child: Card(
                                elevation: 1,
                                color: itemSelected
                                    ? f.primary200
                                    : v.infoContainer,
                                margin: const EdgeInsets.fromLTRB(
                                  12,
                                  0,
                                  12,
                                  12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Column(
                                    children: [
                                      const Text(
                                        "🥗",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        r.score.toStringAsFixed(1),
                                        style: TextStyle(
                                          color: f.primary500,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    r.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: itemSelected
                                          ? f.textcolor700
                                          : v.text,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "⭐ ${r.rating} · ${r.distance.toStringAsFixed(2)} km",
                                    style: TextStyle(
                                      color: itemSelected
                                          ? f.textcolor700
                                          : v.text,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
