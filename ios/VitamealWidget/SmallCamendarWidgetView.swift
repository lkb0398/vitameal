import SwiftUI
import WidgetKit

// Daycell
struct DayCell: Identifiable {
    let id = UUID()
    let day: Int? // nil이면 공백 칸
    let level: AchievementLevel // day가 nil이면 .none
}

// DayCell 색깔
enum AchievementLevel: Int {
    case none = 0 // 미평가(아예 안 칠함)
    case low = 1 // 빨강 (미흡)
    case mid = 2 // 노랑 (보통)
    case high = 3 // 초록 (우수)
    
    /// enum의 성취도 문자열을 AchievementLevel로 변환
    static func from(adherenceString: String?) -> AchievementLevel {
        guard let str = adherenceString else {
            return .none // null → 미평가
        }
        switch str {
        case "not_followed":
            return .low // 빨강
        case "partial":
            return .mid // 노랑
        case "followed":
            return .high // 초록
        default:
            return .none
        }
    }
}

struct SmallCalendarWidgetView: View {
    @Environment(\.widgetRenderingMode) private var widgetRenderingMode // 렌더링 모드
    @Environment(\.colorScheme) private var colorScheme // 라이트,다크 판별
    
    // 틴트모드(.accented) 색상은 고정 RGB대신 .primary/.secondary 사용
    // 틴트모드 모드에서는 시스템 기본색이 아닌 임의의 RGB 색은 넣어도 무시됨
    // 틴트모드에서는 우리 브랜드의 색깔을 유지하려고 하지말고, 시스템의 UI 처럼 보이게 만들어야한다라는 정책
    
    let date: Date // 달력의 기준이 될 날짜
    let achievementsByDay: [Int: AchievementLevel] // 일일 성취도
    let showAdherence: Bool // 위젯 모드 (달성도표시, 미표시)
    
    private var monthTitle: String {
        let f = DateFormatter()
        f.locale = Locale.current
        f.dateFormat = showAdherence ? "yyyy.MM" : "MMMM yyyy"
        return f.string(from: date)
    }
    
    private var gridDays: [DayCell] {
        makeMonthGrid(date: date, achievementsByDay: achievementsByDay)
    }
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 2), count: 7) // 열간격 2
    }
    
    var body: some View {
        // 위젯이 작아서 셀 잘림 현상생김 셀크기 맞춤 계산
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            
            let rows = monthRowCount(for: date) // 5주 6주
            
            // Small에서 안전하게 들어가도록 밀도를 올림
            // 6주면 더 타이트하게
            let titleHeight: CGFloat = (rows == 6) ? 16 : 18 // label 타이틀 영역
            let vPadding: CGFloat = (rows == 6) ? 10 : 14 // 위젯의 상단 패딩
            let gridTopGap: CGFloat = (rows == 6) ? 3 : 8 // 그리드 상단 여백: label과 캘린더의 Tap
            let gridBottomPadding: CGFloat = (rows == 6) ? 10 : 14 // 그리드 하단 여백: 위젯의 하단 패딩
            
            // 그리드에 실제로 쓸 수 있는 높이
            let gridHeight = max(0, h - vPadding - titleHeight - gridTopGap - gridBottomPadding)
            
            // 행 수 기준으로 셀 크기 상한 계산
            // row행 spacing 2 → 총 spacing (row-1)*2 = 10 (=> 3으로 계산해서 좀 간격있게 바꿈)
            let maxCellByHeight = floor((gridHeight - (3 * CGFloat(rows - 1))) / CGFloat(rows))
            
            // 7열 기준 셀 크기 상한 계산
            // 7열 spacing 2 → 총 spacing 6*2 = 12 (=> 3으로 계산해서 좀 간격있게 바꿈)
            // 좌우 패딩 12 고려
            let maxCellByWidth = floor((w - (3 * 6) - 12) / 7)
            
            let cellSize = max(10, min(maxCellByHeight, maxCellByWidth))
            
            // 목표 달성도 (%)
            let percent = WidgetDataManager.adherencePercentRecordedOnly(
                achievementsByDay: achievementsByDay,
                date: date
            )
            
            ZStack {
                if widgetRenderingMode == .fullColor {
                    RoundedRectangle(cornerRadius: 22, style: .continuous) // 모서리 22
                        .fill(Color.widgetBg)
                } else {
                    // 틴트/투명에서는 배경 제거
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(.clear)
                }
                
                VStack(spacing: 0) {
                    // 달성도 표시 버전
                    if showAdherence {
                        HStack(alignment: .center, spacing: 8) {
                            // 왼쪽엔 년,월 라벨
                            Text("\(monthTitle)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(widgetRenderingMode == .fullColor ? Color.widgetText : .primary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                            
                            Spacer(minLength: 6)
                            
                            // 오른쪽엔 달성도 표시
                            HStack(spacing: 4) {
                                if (colorScheme == .dark){
                                    // 다크모드
                                    Image("AdherenceIconDark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                        .foregroundStyle(widgetRenderingMode == .fullColor ? Color.widgetTextSub : .secondary)
                                } else {
                                    Image("AdherenceIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                        .foregroundStyle(widgetRenderingMode == .fullColor ? Color.widgetText : .secondary)
                                }
                                
                                Text("\(percent)%")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundStyle(widgetRenderingMode == .fullColor ? Color.widgetText : .primary)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                            }
                        }
                        .frame(height: titleHeight)
                        .padding(.top, vPadding)
                        .padding(.horizontal, 16)
                    // 달성도 미표시 버전
                    } else {
                        // 타이틀 label, 한 줄 고정 + 축소 허용
                        Text(monthTitle)
                            .font(.system(size: 12, weight: .semibold))
                            // 틴트 모드에서는 시스템 색 사용
                            .foregroundStyle(widgetRenderingMode == .fullColor ? Color.widgetText : .primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                            .frame(height: titleHeight)
                            .padding(.top, vPadding)
                    }
                    
                    Spacer().frame(height: gridTopGap)
                    
                    LazyVGrid(columns: columns, spacing: (rows == 6) ? 2 : 3) { // 행간격
                        ForEach(gridDays) { item in
                            SmallDayCell(
                                day: item.day,
                                level: item.level,
                                size: cellSize,
                                textColor: Color.widgetCell,
                                bgLow: Color.widgetLow,
                                bgMid: Color.widgetMid,
                                bgHigh: Color.widgetHigh
                            )
                        }
                    }
                    .padding(.horizontal, 14) // 좌우 패딩
                    .padding(.bottom, gridBottomPadding)
                    
                    Spacer(minLength: 0)
                }
            }
        }
        .containerBackground(.clear, for: .widget) // 배경 Entry에서 적용
    }
}

private struct SmallDayCell: View {
    @Environment(\.widgetRenderingMode) private var widgetRenderingMode // 렌더링 모드
    
    let day: Int?
    let level: AchievementLevel
    let size: CGFloat
    
    let textColor: Color
    let bgLow: Color
    let bgMid: Color
    let bgHigh: Color
    
    // fullcolor 모드
    private var fillColor: Color {
        switch level {
        case .none: return .clear
        case .low:  return bgLow
        case .mid:  return bgMid
        case .high: return bgHigh
        }
    }
    
    // 틴트 모드일 때 셀 투명도
    private var tintOpacity: Double {
        switch level {
        case .none: return 0.0
        case .low:  return 0.10
        case .mid:  return 0.35
        case .high: return 0.70
        }
    }
    
    var body: some View {
        ZStack {
            if let day {
                let isTint = (widgetRenderingMode != .fullColor)
                RoundedRectangle(cornerRadius: 6, style: .continuous) // 셀 모서리
                    .fill(isTint ? AnyShapeStyle(.tint) : AnyShapeStyle(fillColor))
                    .opacity(isTint ? tintOpacity : 1.0)
                    .widgetAccentable() // 틴트 색
                
                Text("\(day)")
                    .font(.system(size: 10, weight: .medium)) // 셀 폰트
                    .foregroundStyle(widgetRenderingMode == .fullColor ? textColor : .primary)
                    .minimumScaleFactor(0.7)
            } else {
                Color.clear
            }
        }
        .frame(width: size, height: size)
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
