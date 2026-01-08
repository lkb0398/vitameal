import SwiftUI
import WidgetKit

struct LargeCalendarWidgetView: View {
    let date: Date // 달력의 기준이 될 날짜
    let achievementsByDay: [Int: AchievementLevel] // 일일 성취도

    private var monthTitle: String {
        let f = DateFormatter()
        f.locale = Locale.current
        f.dateFormat = "MMMM yyyy"
        return f.string(from: date)
    }

    private var gridDays: [DayCell] {
        makeMonthGrid(date: date, achievementsByDay: achievementsByDay)
    }
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: 7) // 열간격 8
    }


    var body: some View {
        let rows = monthRowCount(for: date)
        let titleHeight: CGFloat = 36 // label 타이틀 영역
        let vPadding: CGFloat = (rows == 6) ? 20 : 36 // 위젯의 상단 패딩
        let gridBottomPadding: CGFloat = (rows == 6) ? 14 : 34 // 그리드 하단 여백: 위젯의 하단 패딩
        
        ZStack {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.widgetBg)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text(monthTitle)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.widgetText)
                    .frame(height: titleHeight)
                    .padding(.top, vPadding)

                DayOfWeekRow()
                    .padding(.horizontal, 24) // 요일 영역 좌우 패딩

                LazyVGrid(columns: columns, spacing: (rows == 6) ? 4 : 8) { // 행간격 8
                    ForEach(gridDays) { item in
                        LargeDayCell(
                            day: item.day,
                            level: item.level,
                            textColor: Color.widgetCell,
                            bgLow: Color.widgetLow,
                            bgMid: Color.widgetMid,
                            bgHigh: Color.widgetHigh
                        )
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.bottom, gridBottomPadding)

                Spacer(minLength: 0)
            }
        }
        .containerBackground(.clear, for: .widget)
    }

    // 요일 라벨 행
    @ViewBuilder
    private func DayOfWeekRow() -> some View {
        let labels = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
        HStack(spacing: 8) {
            ForEach(labels, id: \.self) { t in
                Text(t)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.widgetTextSub)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

private struct LargeDayCell: View {
    let day: Int?
    let level: AchievementLevel

    let textColor: Color
    let bgLow: Color
    let bgMid: Color
    let bgHigh: Color

    private var fillColor: Color {
        switch level {
        case .none: return .clear
        case .low:  return bgLow
        case .mid:  return bgMid
        case .high: return bgHigh
        }
    }

    var body: some View {
        ZStack {
            if let day {
                RoundedRectangle(cornerRadius: 8, style: .continuous) // 셀 모서리
                    .fill(fillColor)

                Text("\(day)")
                    .font(.system(size: 16, weight: .medium)) // 셀 폰트
                    .foregroundStyle(textColor)
            } else {
                Color.clear
            }
        }
    }
}

// 월 그리드 생성
private func makeMonthGrid(
    date: Date,
    achievementsByDay: [Int: AchievementLevel]
) -> [DayCell] {
    var calendar = Calendar.current
    // 시작 요일 맞추기
    // calendar.firstWeekday = 1 // 일요일
    // calendar.firstWeekday = 2 // 월요일

    guard
        let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: date)),
        let range = calendar.range(of: .day, in: .month, for: monthStart)
    else { return [] }

    let daysInMonth = range.count
    let weekday = calendar.component(.weekday, from: monthStart)
    let leadingEmpty = (weekday - calendar.firstWeekday + 7) % 7

    var result: [DayCell] = []
    result.reserveCapacity(leadingEmpty + daysInMonth)

    for _ in 0..<leadingEmpty {
        result.append(DayCell(day: nil, level: .none))
    }

    for day in 1...daysInMonth {
        let level = achievementsByDay[day] ?? .none
        result.append(DayCell(day: day, level: level))
    }

    return result
}

// 몇 주인지 계산
private func monthRowCount(for date: Date, calendar: Calendar = .current) -> Int {
    var cal = calendar

    guard
        let monthStart = cal.date(from: cal.dateComponents([.year, .month], from: date)),
        let range = cal.range(of: .day, in: .month, for: monthStart)
    else { return 6 }

    let daysInMonth = range.count
    let weekday = cal.component(.weekday, from: monthStart)
    let leadingEmpty = (weekday - cal.firstWeekday + 7) % 7

    let totalCells = leadingEmpty + daysInMonth
    let rows = Int(ceil(Double(totalCells) / 7.0))
    return max(5, min(rows, 6)) // 5주 또는 6주
}

