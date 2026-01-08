//
//  VitamealWidget.swift
//  VitamealWidget
//
//  Created by beinny on 1/6/26.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct VitamealWidgetEntryView : View {
    @Environment(\.widgetFamily) private var family
    var entry: Provider.Entry

    var body: some View {
        // 더미 데이터
        let sample: [Int: AchievementLevel] = [
            1: .mid, 2: .mid, 3: .low, 6: .high, 8: .mid, 9: .high,
            13: .high, 16: .mid, 20: .high, 21: .high, 23: .high, 27: .mid, 30: .high
        ]
        
        Group {
            switch family {
            case .systemLarge:
                LargeCalendarWidgetView(date: Calendar.current.date(
                    from: DateComponents(year: 2026, month: 8, day: 1)
                )!, achievementsByDay: sample)
            case .systemSmall:
                SmallCalendarWidgetView(date: entry.date, achievementsByDay: sample)
            default:
                LargeCalendarWidgetView(date: entry.date, achievementsByDay: sample)
                   }
               }
        .containerBackground(for: .widget) {
            GlassBackground(cornerRadius: 22)
        }
    }
}

struct VitamealWidget: Widget {
    let kind: String = "VitamealWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            VitamealWidgetEntryView(entry: entry)
        }.contentMarginsDisabled().supportedFamilies([
            .systemSmall,
            .systemLarge
        ])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    VitamealWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
