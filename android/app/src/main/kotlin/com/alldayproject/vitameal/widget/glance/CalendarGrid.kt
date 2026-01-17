package com.alldayproject.vitameal.widget.glance

import com.alldayproject.vitameal.widget.data.model.AchievementLevel
import com.alldayproject.vitameal.widget.data.model.DayCell
import java.time.DayOfWeek
import java.time.LocalDate
import java.time.YearMonth
import kotlin.math.ceil
import kotlin.math.round

object CalendarGrid {
    /** 셀 리스트 생성 */
    fun makeMonthGrid(year: Int, month: Int, achievementsByDay: Map<Int, AchievementLevel>): List<DayCell> {
        val ym = YearMonth.of(year, month) // 년월
        val monthStart = LocalDate.of(year, month, 1) // 시작일
        val daysInMonth = ym.lengthOfMonth() // 월 길이

        val firstWeekday = DayOfWeek.SUNDAY // 주의 맨앞에 오는 시작요일

        val weekdayOfStart = monthStart.dayOfWeek
        val leadingEmpty = ((weekdayIndex(weekdayOfStart) - weekdayIndex(firstWeekday) + 7) % 7) // 앞의 빈칸 계산

        val result = ArrayList<DayCell>(leadingEmpty + daysInMonth) // 빈칸 + 월 길이 만큼
        repeat(leadingEmpty) { result.add(DayCell(day = null, level = AchievementLevel.NONE)) } // 빈칸 셀들 채우기

        // 실제 날짜 채우기
        for (d in 1..daysInMonth) {
            val level = achievementsByDay[d] ?: AchievementLevel.NONE
            result.add(DayCell(day = d, level = level))
        }
        return result
    }

    /** 위젯에 표시할 달의 행 수 계산 */
    fun monthRowCount(year: Int, month: Int): Int {
        val ym = YearMonth.of(year, month)
        val monthStart = LocalDate.of(year, month, 1)
        val daysInMonth = ym.lengthOfMonth()

        val firstWeekday = DayOfWeek.SUNDAY
        val leadingEmpty = ((weekdayIndex(monthStart.dayOfWeek) - weekdayIndex(firstWeekday) + 7) % 7)

        val totalCells = leadingEmpty + daysInMonth
        val rows = ceil(totalCells / 7.0).toInt()
        return rows.coerceIn(5, 6) // 4행짜리는 5행 템플릿 사용
    }

    /** 요일 -> 0~6 변환 */
    private fun weekdayIndex(d: DayOfWeek): Int {
        // SUNDAY=0 ... SATURDAY=6
        return when (d) {
            DayOfWeek.SUNDAY -> 0
            DayOfWeek.MONDAY -> 1
            DayOfWeek.TUESDAY -> 2
            DayOfWeek.WEDNESDAY -> 3
            DayOfWeek.THURSDAY -> 4
            DayOfWeek.FRIDAY -> 5
            DayOfWeek.SATURDAY -> 6
        }
    }

    /** 달성도 퍼센트 계산 */
    fun adherencePercent(achievementsByDay: Map<Int, AchievementLevel>, year: Int, month: Int): Int {
        val today = LocalDate.now()
        // 이번 달 이면 오늘까지 계산, 이전 달이면 말일까지 계산
        val dayLimit = if (today.year == year && today.monthValue == month) today.dayOfMonth else YearMonth.of(year, month).lengthOfMonth()

        var sum = 0.0
        var count = 0.0

        for (d in 1..dayLimit) {
            val level = achievementsByDay[d] ?: AchievementLevel.NONE
            count += 1.0
            sum += when (level) {
                AchievementLevel.LOW, AchievementLevel.NONE -> 0.0
                AchievementLevel.MID -> 0.5
                AchievementLevel.HIGH -> 1.0
            }
        }
        if (count <= 0) return 0
        return round((sum / count) * 100).toInt()
    }
}