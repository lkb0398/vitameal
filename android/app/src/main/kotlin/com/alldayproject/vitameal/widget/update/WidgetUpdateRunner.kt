package com.alldayproject.vitameal.widget.update

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import androidx.glance.GlanceId
import androidx.glance.appwidget.GlanceAppWidgetManager
import com.alldayproject.vitameal.widget.glance.VitamealSmallGlanceWidget
import com.alldayproject.vitameal.widget.receiver.VitamealSmallWidgetReceiver
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock

/** Glance 위젯이 업데이트 안 되는 문제를 피하기 위해
런처(AppWidgetManager)와 Glance를 둘 다 강제로 깨워서 갱신하는 러너

Android 12+ Glance에서 이슈 : 최초 1회만 갱신, 이후 update() 호출해도 50초 세션락으로 화면이 안 바뀌는 문제 */
object WidgetUpdateRunner {
    // 백그라운드 연산
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Default)

    private const val PREF = "widget_update_runner"
    private const val KEY_LAST_ATTEMPT_PREFIX = "last_attempt_ms_" // + <gidKey>
    private const val DEBOUNCE_MS = 1500L
    private const val LOCK_WINDOW_MS = 55_000L // 55초

    // gid별 상태
    private val mutexMap = mutableMapOf<String, Mutex>()
    private val jobMap = mutableMapOf<String, Job?>()

    // 런처를 broadcast로 먼저 깨우고, 그 다음 Glance 인스턴스 update를 걸어준다.
    fun forceUpdateSmall(context: Context) {
        val appCtx = context.applicationContext
        scope.launch {
            // 런처 깨우기
            val awm = AppWidgetManager.getInstance(appCtx)
            val cn = ComponentName(appCtx, VitamealSmallWidgetReceiver::class.java)
            val ids = awm.getAppWidgetIds(cn)

            if (ids.isNotEmpty()) {
                val intent = Intent(appCtx, VitamealSmallWidgetReceiver::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
                }
                appCtx.sendBroadcast(intent)
            }

            // Glance 인스턴스별 update
            val manager = GlanceAppWidgetManager(appCtx)
            val glanceIds = manager.getGlanceIds(VitamealSmallGlanceWidget::class.java)

            glanceIds.forEach { gid ->
                scheduleUpdateForGid(appCtx, VitamealSmallGlanceWidget(), gid)
            }
        }
    }

    /** gid별로
     * 이전 예약 취소(디바운싱), lastAttempt 기반으로 락 윈도우 회피(스로틀링)
     * 딜레이 후 update(appCtx, gid) 1회 실행
     */
    private fun scheduleUpdateForGid(appCtx: Context, widget: VitamealSmallGlanceWidget, gid: GlanceId) {
        val gidKey = gid.toStableKey()

        val mutex = synchronized(mutexMap) {
            mutexMap.getOrPut(gidKey) { Mutex() }
        }

        scope.launch {
            mutex.withLock {
                // gid별 디바운스 - 이전 예약 취소
                synchronized(jobMap) {
                    jobMap[gidKey]?.cancel()
                }

                val prefs = appCtx.getSharedPreferences(PREF, Context.MODE_PRIVATE)
                val lastKey = KEY_LAST_ATTEMPT_PREFIX + gidKey

                val now = System.currentTimeMillis()
                val lastAttempt = prefs.getLong(lastKey, 0L)
                val elapsed = now - lastAttempt // 마지막 시도 이후 지난 시간

                // 55초 이상 지났을 경우
                val delayMs = if (elapsed >= LOCK_WINDOW_MS) {
                    DEBOUNCE_MS
                } else {
                    // 남은 쿨타임 계산
                    (LOCK_WINDOW_MS - elapsed) + DEBOUNCE_MS
                }

                val job = scope.launch {
                    delay(delayMs)
                    // gid별 lastAttempt 기록
                    prefs.edit()
                        .putLong(lastKey, System.currentTimeMillis())
                        .apply()
                    // 해당 gid만 업데이트
                    widget.update(appCtx, gid)
                }

                synchronized(jobMap) {
                    jobMap[gidKey] = job
                }
            }
        }
    }

    // 위젯 인스턴스를 구분하기 위한 문자열 생성 함수
    private fun GlanceId.toStableKey(): String = this.toString()
}