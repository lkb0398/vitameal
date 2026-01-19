package com.alldayproject.vitameal.widget.glance

import android.content.Context
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager

/** appWidgetId로 인스턴스를 찾아서 해당 인스턴스만 업데이트한다 */
suspend fun GlanceAppWidget.updateByAppWidgetId(context: Context, appWidgetId: Int) {
    val manager = GlanceAppWidgetManager(context)
    val glanceId = manager.getGlanceIdBy(appWidgetId)
    this.update(context, glanceId)
}
