package com.alldayproject.vitameal.widget.receiver

import androidx.glance.appwidget.GlanceAppWidgetReceiver
import com.alldayproject.vitameal.widget.glance.VitamealSmallGlanceWidget

// Android AppWidgetProvider의 Glance 버전
// Android 시스템이 위젯 이벤트를 여기로 전달함
// manifest에 등록 해야함
class VitamealSmallWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = VitamealSmallGlanceWidget()
}