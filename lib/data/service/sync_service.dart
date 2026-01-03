import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/util/date_time_utils.dart';
import 'package:vitameal/data/data_source/meal_remote_data_source.dart';
import 'package:vitameal/data/dto/meal_day_dto.dart';
import 'package:vitameal/data/dto/meal_entry_dto.dart';
import 'package:vitameal/data/database/database.dart';
import 'package:vitameal/data/mapper/meal_day_mapper.dart';
import 'package:vitameal/data/mapper/meal_entry_mapper.dart';

class SyncService {
  /// outbox 기반 동기화 
  SyncService({
    required AppDatabase database,
    required MealRemoteDataSource remoteDataSource,
    required SupabaseClient supabase,
    Connectivity? connectivity,
  }) : _database = database,
       _remoteDataSource = remoteDataSource,
       _supabase = supabase,
       _connectivity = connectivity ?? Connectivity();
       
  final AppDatabase _database;
  final MealRemoteDataSource _remoteDataSource;
  final SupabaseClient _supabase;
  final Connectivity _connectivity;

  // 동기화 상태
  bool _isSyncing = false;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// SyncService 시작
  Future<void> start() async {
    debugPrint('🔄 SyncService 시작');
    _startNetworkListener(); // 네트워크 상태 감지 시작
    await syncAll(); // 앱 시작 시 한 번 동기화
  }

  /// SyncService 중지
  void stop() {
    _connectivitySubscription?.cancel();
  }

  /// 전체 동기화 (Outbox 처리 + 증분 동기화)
  Future<void> syncAll() async {
    debugPrint('🔄 syncAll() 함수 시작');

    if (_isSyncing) {
      debugPrint('🔄 이미 동기화 진행 중임 syncAll() 중단');
      return; // 이미 동기화 중이면 스킵
    }

    // 네트워크 확인
    final hasNetwork = await _checkNetworkConnectivity();
    debugPrint('🔄 네트워크 체크 결과 [$hasNetwork]');
    if (!hasNetwork) {
      debugPrint('🔄 네트워크 없음 syncAll() 중단');
      return;
    }

    _isSyncing = true;
    debugPrint('🔄 동기화 진행 중...');

    try {
      // 1. Outbox 처리 (로컬 > 서버)
      await _processOutbox();

      // 2. 증분 동기화 (서버 > 로컬)
      await _performIncrementalSync();

      debugPrint('🔄 동기화 완료');
    } catch (e) {
      debugPrint('🔄 동기화 실패 [$e]');
    } finally {
      _isSyncing = false;
    }
  }

  /// 네트워크 연결 감지 시작
  void _startNetworkListener() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (results) {
        final hasNetwork = results.any((result) =>
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet);

        // 네트워크 복구 시 동기화 실행
        // (오프라인 중 쌓인 Outbox 전송 + 다른 기기 변경사항 가져오기)
        if (hasNetwork) {
          syncAll();
        }
      },
    );
  }

  /// 네트워크 연결 상태 확인
  Future<bool> _checkNetworkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet);
  }

  // ========== Outbox 처리 (로컬 > 서버 동기화) ==========

  /// Outbox 큐 처리
  Future<void> _processOutbox() async {
    // 대기 중인 모든 작업 조회
    final pendingTasks = await _database.outboxDao.getAllPendingOutbox();

    debugPrint('📦 Outbox 처리 시작 [대기중인 작업 ${pendingTasks.length}개]');

    for (final task in pendingTasks) {
      try {
        debugPrint('📦 처리 시작 ${task.operation}@${task.targetTable}[${task.recordId.substring(0, 8)}...]');
        await _processOutboxTask(task);

        // 성공 시 Outbox에서 제거
        await _database.outboxDao.deleteOutbox(task.id);
        debugPrint('📦 성공 ${task.operation}@${task.targetTable}[${task.recordId.substring(0, 8)}...]');
      } catch (e) {
        debugPrint('📦 실패 ${task.operation}@${task.targetTable}[${task.recordId.substring(0, 8)}...]: $e');
        // 실패 시 재시도 횟수 증가 시키기
        await _database.outboxDao.updateOutboxRetry(
          outboxId: task.id,
          error: e.toString(),
        );
        // 재시도 횟수가 5회 초과면 스킵
        if (task.retryCount >= 5) {
          debugPrint('📦 재시도 횟수 5회 이상 [${task.id}]');
        }
      }
    }
  }

  /// 개별 Outbox 작업 처리
  Future<void> _processOutboxTask(OutboxData task) async {
    final payload = jsonDecode(task.payload) as Map<String, dynamic>;

    switch (task.targetTable) {
      case 'meal_days':
        await _processMealDayTask(task.operation, task.recordId, payload);
        break;
      case 'meal_entries':
        await _processMealEntryTask(task.operation, task.recordId, payload);
        break;
      default:
        throw Exception('잘못된 테이블 ㅠㅠ [${task.targetTable}]');
    }
  }

  /// MealDay 동기화 처리 (로컬 > 서버)
  Future<void> _processMealDayTask(
    String operation,
    String recordId,
    Map<String, dynamic> payload,
  ) async {
    switch (operation) {
      case 'insert':
        await _supabase.from('meal_days').insert(payload);
        break;
      case 'update':
        await _supabase.from('meal_days').update(payload).eq('id', recordId);
        break;
      case 'delete':
        await _supabase.from('meal_days').update(payload).eq('id', recordId);
        break;
    }
    debugPrint('📦🌈 MealDay 동기화 [$operation, id=${recordId.substring(0, 8)}]');
  }

  /// MealEntry 동기화 처리 (로컬 > 서버)
  Future<void> _processMealEntryTask(
    String operation,
    String recordId,
    Map<String, dynamic> payload,
  ) async {
    switch (operation) {
      case 'insert':
        await _supabase.from('meal_entries').insert(payload);
        break;
      case 'update':
        await _supabase.from('meal_entries').update(payload).eq('id', recordId);
        break;
      case 'delete':
        // Delete RLS 에러 -> 삭제를 RPC로 전환해서 RLS 문제 해결
        await _supabase.rpc('soft_delete_meal_entry', params: {'p_entry_id': recordId});
        break;
    }
    debugPrint('📦🌈 MealEntry 동기화 [$operation, id=${recordId.substring(0, 8)}]');
  }

  // ========== 증분 동기화 (서버 > 로컬 동기화) ==========

  /// 증분 동기화 수행
  Future<void> _performIncrementalSync() async {
    debugPrint('☁️ 증분 동기화 처리 시작');
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      debugPrint('☁️ 로그인 에러, 증분 동기화 취소');
      return;
    }

    // MealDays 동기화
    await _syncMealDays(userId);

    // MealEntries 동기화
    await _syncMealEntries(userId);

    debugPrint('☁️ 증분 동기화 완료');
  }

  /// MealDays 증분 동기화
  Future<void> _syncMealDays(String userId) async {
    // 로컬 테이블의 마지막 동기화 시간 조회
    final lastSyncAt = await _database.syncMetadataDao.getLastSyncAt(
      userId: userId,
      targetTable: 'meal_days',
    );

    debugPrint('☁️🥕 MealDays의 lastSyncAt [${lastSyncAt?.logFormat ?? 'NEVER'}]');

    // 변경 사항 조회 (RPC 함수 호출)
    final response = await _supabase.rpc(
      'get_meal_days_changes',
      params: {
        'p_user_id': userId,
        'p_last_sync_at':
            lastSyncAt?.toIso8601String() ?? '1970-01-01T00:00:00Z',
      },
    );

    final changes = (response as List)
        .map((json) => MealDayDto.fromJson(json))
        .toList();

    debugPrint('☁️🌈 서버로 부터 받아온 MealDay 변경 사항 [${changes.length}개]');

    // 로컬에 적용
    for (final dto in changes) {
      if (dto.deletedAt != null) {
        await _database.mealDao.hardDeleteMealDay(dto.id);
        debugPrint('☁️🥕 MealDay delete [${dto.id.substring(0, 8)}, ${dto.mealDate}]');
      } else {
        await _database.mealDao.upsertMealDay(dto.toEntity().toCompanion());
        debugPrint('☁️🥕 MealDay upsert [${dto.id.substring(0, 8)}, ${dto.mealDate}]');
      }
    }

    // 마지막 동기화 시간 업데이트
    await _database.syncMetadataDao.updateLastSyncAt(
      userId: userId,
      targetTable: 'meal_days',
      lastSyncAt: DateTime.now(),
    );
  }

  /// MealEntries 증분 동기화
  Future<void> _syncMealEntries(String userId) async {
    // 로컬 테이블의 마지막 동기화 시간 조회
    final lastSyncAt = await _database.syncMetadataDao.getLastSyncAt(
      userId: userId,
      targetTable: 'meal_entries',
    );

    debugPrint('☁️🥕 MealEntries의 lastSyncAt [${lastSyncAt?.logFormat ?? 'NEVER'}]');

    // 변경 사항 조회 (RPC 함수 호출)
    final response = await _supabase.rpc(
      'get_meal_entries_changes',
      params: {
        'p_user_id': userId,
        'p_last_sync_at':
            lastSyncAt?.toIso8601String() ?? '1970-01-01T00:00:00Z',
      },
    );

    final changes = (response as List)
        .map((json) => MealEntryDto.fromJson(json))
        .toList();

    debugPrint('☁️🌈 서버로 부터 받아온 MealEntries 변경 사항 [${changes.length}개]');

    // 로컬에 적용
    for (final dto in changes) {
      if (dto.deletedAt != null) {
        await _database.mealDao.hardDeleteMealEntry(dto.id);
        debugPrint('☁️🥕 MealEntries delete [${dto.id.substring(0, 8)}]');
      } else {
        await _database.mealDao.upsertMealEntry(dto.toEntity().toCompanion());
        debugPrint('☁️🥕 MealEntries upsert [${dto.id.substring(0, 8)}]');
      }
    }

    // 마지막 동기화 시간 업데이트
    await _database.syncMetadataDao.updateLastSyncAt(
      userId: userId,
      targetTable: 'meal_entries',
      lastSyncAt: DateTime.now(),
    );
  }
}
