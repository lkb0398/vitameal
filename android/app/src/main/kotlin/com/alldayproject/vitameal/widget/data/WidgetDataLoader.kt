package com.alldayproject.vitameal.widget.data

import android.content.Context
import com.alldayproject.vitameal.widget.data.model.AchievementLevel
import com.alldayproject.vitameal.widget.data.model.WidgetCalendarData
import kotlinx.serialization.json.Json
import kotlin.collections.iterator

/** 위젯 데이터 로더 (Repository 느낌) */
object WidgetDataLoader {
    // 정의되지않은 필드 무시
    private val json = Json { ignoreUnknownKeys = true }

    /** SharedPreferences로 부터 데이터를 불러와 WidgetCalendarData 객체 생성 */
    fun load(context: Context): WidgetCalendarData? {
        // SharedPreferences에서 JSON 문자열 로드
        val raw = WidgetPrefs.loadCalendarJson(context) ?: return null
        return try {
            // JSON을 WidgetCalendarData 객체로 파싱, 이걸 위젯에서 사용함
            json.decodeFromString(WidgetCalendarData.serializer(), raw)
        } catch (_: Exception) {
            null
        }
    }

    /** 날짜별 성취도를 enum 형태로 변환 */
    fun achievementsByDay(data: WidgetCalendarData): Map<Int, AchievementLevel> {
        val result = HashMap<Int, AchievementLevel>()
        for ((dayStr, v) in data.achievements) {
            val day = dayStr.toIntOrNull() ?: continue
            val level = AchievementLevel.Companion.from(v)
            if (level != AchievementLevel.NONE) result[day] = level
        }
        // 자가평가 있는 날들의 Map 반환
        return result
    }
}