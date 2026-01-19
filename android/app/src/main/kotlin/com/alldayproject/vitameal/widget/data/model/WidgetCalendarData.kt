package com.alldayproject.vitameal.widget.data.model

import kotlinx.serialization.Serializable

/** JSON의 DTO */
@Serializable
data class WidgetCalendarData(
    val year: Int,
    val month: Int,
    val achievements: Map<String, String?> // "1": "followed", "2": "partial", "3": "not_followed", 4: null, ... 형태
)

/** 자가평가 매핑용 enum */
enum class AchievementLevel {
    NONE, LOW, MID, HIGH;

    companion object {
        fun from(adherence: String?): AchievementLevel = when (adherence) {
            "not_followed" -> LOW
            "partial" -> MID
            "followed" -> HIGH
            else -> NONE
        }
    }
}

/** 위젯에서 셀을 표현할 데이터 클래스 */
data class DayCell(
    val day: Int?, // null이면 빈칸
    val level: AchievementLevel
)
