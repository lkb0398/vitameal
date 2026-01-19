package com.alldayproject.vitameal.widget.data

import android.content.Context
import android.content.SharedPreferences
import com.alldayproject.vitameal.widget.style.WidgetFontAndBorderStyle
import com.alldayproject.vitameal.widget.style.WidgetPaletteStyle

/** SharedPreferences helper */
object WidgetPrefs {
    private const val PREFS = "vitameal_widget_prefs" // 위젯 SharedPreferences 키
    private const val KEY_CALENDAR_JSON = "widgetCalendarData" // 캘린더 데이터 키

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

    fun styleKey(appWidgetId: Int) = "style_$appWidgetId" // 폰트+테두리 색 설정
    fun adherenceKey(appWidgetId: Int) = "showAdherence_$appWidgetId" // 달성도 표시 설정
    private fun borderOpacityKey(appWidgetId: Int) = "borderOpacity_$appWidgetId" // 테두리 투명도 설정
    private fun paletteKey(appWidgetId: Int) = "palette_$appWidgetId" // 셀 컬러 파레트 설정

    /** 폰트+테두리 색 설정 불러오기 (블랙,화이트) */
    fun loadStyle(context: Context, appWidgetId: Int): String =
        prefs(context).getString(styleKey(appWidgetId), WidgetFontAndBorderStyle.WHITE)
            ?: WidgetFontAndBorderStyle.WHITE // 기본 화이트

    /** 폰트+테두리 색 설정 저장 (블랙,화이트) */
    fun saveStyle(context: Context, appWidgetId: Int, style: String) {
        prefs(context).edit().putString(styleKey(appWidgetId), style).apply()
    }

    /** 위젯 달성도 표시 설정 불러오기 (표시,미표시) */
    fun loadShowAdherence(context: Context, appWidgetId: Int): Boolean =
        prefs(context).getBoolean(adherenceKey(appWidgetId), true) // 기본 표시


    /** 위젯 달성도 표시 설정 저장 (표시,미표시) */
    fun saveShowAdherence(context: Context, appWidgetId: Int, show: Boolean) {
        prefs(context).edit().putBoolean(adherenceKey(appWidgetId), show).apply()
    }

    /** 테두리 투명도 설정 불러오기 */
    fun loadBorderOpacity(context: Context, appWidgetId: Int): Int =
        prefs(context).getInt(borderOpacityKey(appWidgetId), 40) // 기본 40

    /** 테두리 투명도 설정 저장 */
    fun saveBorderOpacity(context: Context, appWidgetId: Int, value: Int) {
        prefs(context).edit().putInt(borderOpacityKey(appWidgetId), value.coerceIn(0, 100)).apply()
    }

    /** 셀 컬러 파레트 설정 불러오기 */
    fun loadPalette(context: Context, appWidgetId: Int): String =
        prefs(context).getString(paletteKey(appWidgetId), WidgetPaletteStyle.RYG)
            ?: WidgetPaletteStyle.RYG // 기본 3색

    /** 셀 컬러 파레트 설정 저장 */
    fun savePalette(context: Context, appWidgetId: Int, palette: String) {
        prefs(context).edit().putString(paletteKey(appWidgetId), palette).apply()
    }
}
