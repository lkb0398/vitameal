package com.alldayproject.vitameal.widget.data

import android.content.Context
import android.content.SharedPreferences

/** SharedPreferences helper */
object WidgetPrefs {
    private const val PREFS = "vitameal_widget_prefs"
    private const val KEY_CALENDAR_JSON = "widgetCalendarData"

    private const val KEY_WIDGET_SIDE_DP = "widget_side_dp_"

    fun prefs(context: Context): SharedPreferences =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    // 위젯에 사용될 데이터를 저장
    fun saveCalendarJson(context: Context, json: String) {
        prefs(context).edit().putString(KEY_CALENDAR_JSON, json).commit()
    }

    // 위젯에 사용될 데이터를 불러오기
    fun loadCalendarJson(context: Context): String? =
        prefs(context).getString(KEY_CALENDAR_JSON, null)

    // 아래 속성들은 위젯 하나하나 마다 다르게 관리되는 속성들

    fun styleKey(appWidgetId: Int) = "style_$appWidgetId" // 위젯 폰트색 블랙,화이트

    fun adherenceKey(appWidgetId: Int) = "showAdherence_$appWidgetId" // 위젯 모드 달성도 표시,미표시

    fun loadStyle(context: Context, appWidgetId: Int): String =
        prefs(context).getString(styleKey(appWidgetId), "white") ?: "white" // 폰트색 설정 로드 기본 블랙

    fun loadShowAdherence(context: Context, appWidgetId: Int): Boolean =
        prefs(context).getBoolean(adherenceKey(appWidgetId), false) // 모드 설정 로드 기본 심플

    fun saveStyle(context: Context, appWidgetId: Int, style: String) {
        prefs(context).edit().putString(styleKey(appWidgetId), style).apply() // 폰트색 설정 저장
    }

    fun saveShowAdherence(context: Context, appWidgetId: Int, show: Boolean) {
        prefs(context).edit().putBoolean(adherenceKey(appWidgetId), show).apply() // 모드 위젯 모드 설정 저장
    }


    fun saveWidgetSideDp(context: Context, appWidgetId: Int, sideDp: Int) {
        prefs(context).edit()
            .putInt(KEY_WIDGET_SIDE_DP + appWidgetId, sideDp)
            .apply()
    }

    fun loadWidgetSideDp(context: Context, appWidgetId: Int): Int {
        return prefs(context).getInt(KEY_WIDGET_SIDE_DP + appWidgetId, 110)
    }
}
