import WidgetKit
import SwiftUI
import AppIntents

/// 위젯 Entry
struct CalendarEntry: TimelineEntry {
    let date: Date
    let data: WidgetCalendarData?
}

/// Timeline 프로바이더: WidgetKit이 언제 어떤 Entry를 위젯에 보여줄지 결정하기 위해 호출하는 객체
struct CalendarProvider: TimelineProvider {
    /// placeholder 제공 (로딩용)
    /// 위젯 갤러리에서 아주 잠깐 보임
    func placeholder(in context: Context) -> CalendarEntry {
        let now = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)
        // 플레이스홀더 데이터
        let placeholderData = WidgetCalendarData(
            year: year,
            month: month,
            achievements: [:]
        )
        return CalendarEntry(date: now, data: placeholderData)
    }
    
    /// snapshot 제공 (위젯 추가화면 / 편집 화면용)
    func getSnapshot(in context: Context, completion: @escaping (CalendarEntry) -> Void) {
        // App Group 데이터가 있으면 실제 데이터를 그대로 사용
        // 없으면 fallback 데이터
        let entry = createEntry()
        completion(entry)
    }
    
    /// 위젯 최초 로드, 갱신시 호출
    /// 위젯은 TimelineProvider가 반환한 Timeline 엔트리의 날짜를 기준으로 화면을 그림
    func getTimeline(in context: Context, completion: @escaping (Timeline<CalendarEntry>) -> Void) {
        // Entry 생성, 이 엔트리가 홈에서 유지되는거
        let entry = createEntry()
        
        // 월이 바뀌면 위젯 자동 갱신 트리거
        let calendar = Calendar.current
        let now = Date()
        // 현재날짜에서
        var components = calendar.dateComponents([.year, .month], from: now)
        // 다음달로이동
        components.month! += 1
        // 날짜를 1일로 0시로 설정
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        // 예외 처리
        let nextMonthDate = calendar.date(from: components) ?? calendar.date(byAdding: .day, value: 30, to: now)!
        
        // 해당 시간에 Timeline 생성 = 다음 달 1일에 자동 갱신됨
        let timeline = Timeline(entries: [entry], policy: .after(nextMonthDate))
        
        print("🍎 Widget Timeline 생성 완료 [다음 갱신 \(nextMonthDate)]")
        completion(timeline)
    }
    
    /// Entry 생성 (App Group에서 데이터 읽기)
    private func createEntry() -> CalendarEntry {
        let now = Date()
        // App Group의 UserDefaults에서 데이터 로드
        let data = WidgetDataManager.shared.loadData()
        
        // 데이터있으면 그대로 사용
        let finalData: WidgetCalendarData
        if let loadedData = data {
            finalData = loadedData
        } else { // 데이터 없으면 fallback 데이터 생성
            let calendar = Calendar.current
            let year = calendar.component(.year, from: now)
            let month = calendar.component(.month, from: now)
            finalData = WidgetCalendarData(year: year, month: month, achievements: [:])
        }
        
        return CalendarEntry(date: now, data: finalData)
    }
}

struct VitamealWidgetEntryView : View {
    var entry: CalendarProvider.Entry // TimelineProvider가 전달해주는 위젯에 그려질 데이터
    let showAdherence: Bool
    @Environment(\.widgetFamily) var family // 현재 위젯의 크기
    
    var body: some View {
        if let data = entry.data {
            // WidgetCalendarData를 Int: AchievementLevel로 변환
            let achievementsByDay = convertToAchievementLevels(data: data)
            
            // data.year data.month를 Date로 변환
            let calendar = Calendar.current
            let displayDate = calendar.date(from: DateComponents(year: data.year, month: data.month, day: 1)) ?? Date()
            
            // 테스트용 데이터
            let testDate = Calendar.current.date(
                from: DateComponents(year: 2026, month: 8, day: 1)
            )!
            let testData: [Int: AchievementLevel] = [
                1: .mid, 2: .mid, 3: .low, 6: .high, 8: .mid, 9: .high,
                13: .high, 16: .mid, 20: .high, 21: .high, 23: .high, 27: .mid, 30: .high
            ]
            
            Group {
                switch family {
                case .systemLarge:
                    LargeCalendarWidgetView(date: displayDate, achievementsByDay: achievementsByDay, showAdherence: showAdherence)
                case .systemSmall:
                    SmallCalendarWidgetView(date: displayDate, achievementsByDay: achievementsByDay, showAdherence: showAdherence)
                default:
                    SmallCalendarWidgetView(date: displayDate, achievementsByDay: achievementsByDay, showAdherence: showAdherence)
                }
            }
        } else {
            // 데이터 없을 경우 플레이스홀더
            VStack {
                Text("데이터를 불러올 수 없습니다")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .containerBackground(for: .widget) {
                Color(.systemBackground)
            }
        }
    }
    
    /// WidgetCalendarData를 Int: AchievementLevel로 변환
    private func convertToAchievementLevels(data: WidgetCalendarData) -> [Int: AchievementLevel] {
        var result: [Int: AchievementLevel] = [:]
        
        for (dayString, adherenceString) in data.achievements {
            guard let day = Int(dayString) else { continue }
            let level = AchievementLevel.from(adherenceString: adherenceString)
            
            // .none이 아닌 경우만 추가 (위젯 그릴때 nil은 자동으로 .none 처리함)
            if level != .none {
                result[day] = level
            }
        }
        
        return result
    }
}

struct VitamealWidget: Widget {
    let kind: String = "VitamealWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CalendarProvider()) { entry in
            VitamealWidgetEntryView(entry: entry, showAdherence: false)
        }
        .configurationDisplayName(LocalizedStringResource("diet_widget_name"))
        .description(LocalizedStringResource("diet_widget_desc"))
        .contentMarginsDisabled().supportedFamilies([
            .systemSmall,
            .systemLarge
        ])
    }
}

struct VitamealWidgetSimple: Widget {
    let kind = "VitamealWidgetSimple"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CalendarProvider()) { entry in
            VitamealWidgetEntryView(entry: entry, showAdherence: false)
        }
        .configurationDisplayName(LocalizedStringResource("diet_widget_name"))
        .description(LocalizedStringResource("diet_widget_desc"))
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}

struct VitamealWidgetWithAdherence: Widget {
    let kind = "VitamealWidgetWithAdherence"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CalendarProvider()) { entry in
            VitamealWidgetEntryView(entry: entry, showAdherence: true)
        }
        .configurationDisplayName(LocalizedStringResource("diet_widget_name"))
        .description(LocalizedStringResource("diet_widget_adherence_desc"))
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}


/// xcode 프리뷰
#Preview(as: .systemMedium) {
    VitamealWidget()
} timeline: {
    let sampleData = WidgetCalendarData(
        year: 2026,
        month: 1,
        achievements: [
            "1": "followed",
            "2": "partial",
            "3": "not_followed",
            "4": nil,
            "5": "followed"
        ]
    )
    CalendarEntry(date: Date(), data: sampleData)
}

/// 사용자가 위젯을 길게 눌러 편집 상태에서 보여지는 옵션
struct CalendarConfigurationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "widget_config_title"
    static var description = IntentDescription(LocalizedStringResource("widget_config_desc"))
}
