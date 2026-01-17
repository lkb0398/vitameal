package com.alldayproject.vitameal.widget.update

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import androidx.glance.appwidget.GlanceAppWidgetManager
import com.alldayproject.vitameal.widget.glance.VitamealSmallGlanceWidget
import com.alldayproject.vitameal.widget.receiver.VitamealSmallWidgetReceiver
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch

/** Glance 위젯이 업데이트 안 되는 문제를 피하기 위해
런처(AppWidgetManager)와 Glance를 둘 다 강제로 깨워서 갱신하는 러너

Android 12+ Glance에서 이슈 : 최초 1회만 갱신, 이후 update() 호출해도 화면이 안 바뀌는 문제 */
object WidgetUpdateRunner {
    // 백그라운드 연산
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Default)

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
                VitamealSmallGlanceWidget().update(appCtx, gid)
            }
        }
    }
}