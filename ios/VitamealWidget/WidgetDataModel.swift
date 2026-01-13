import Foundation
import SwiftUI

/// 위젯 데이터 모델
struct WidgetCalendarData: Codable {
    let year: Int
    let month: Int
    let achievements: [String: String?]
    
    enum CodingKeys: String, CodingKey {
        case year, month, achievements
    }
    
    init(year: Int, month: Int, achievements: [String: String?]) {
        self.year = year
        self.month = month
        self.achievements = achievements
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        year = try container.decode(Int.self, forKey: .year)
        month = try container.decode(Int.self, forKey: .month)
        
        // achievements는 String: String? 형태로 파싱 (nil도 반영-무색)
        let achievementsDict = try container.decode([String: String?].self, forKey: .achievements)
        achievements = achievementsDict
    }
}

/// App Group에서 위젯 데이터 읽기
class WidgetDataManager {
    static let shared = WidgetDataManager()
    private let suiteName = "group.com.alldayproject.vitameal.widgets"
    private let dataKey = "widgetCalendarData"
    
    /// 현재 월의 위젯 데이터 조회
    func loadData() -> WidgetCalendarData? {
        guard let userDefaults = UserDefaults(suiteName: suiteName),
              let jsonString = userDefaults.string(forKey: dataKey),
              let jsonData = jsonString.data(using: .utf8) else {
            print("🍎 Widget 데이터 없음")
            return nil
        }
        
        do {
            let data = try JSONDecoder().decode(WidgetCalendarData.self, from: jsonData)
            print("🍎 Widget 데이터 로드 성공 [\(data.year)년 \(data.month)월]")
            return data
        } catch {
            print("🍎 Widget JSON 파싱 실패: \(error)")
            return nil
        }
    }
    
    /// 달성률 계산
    static func adherencePercentRecordedOnly(
        achievementsByDay: [Int: AchievementLevel],
        date: Date
    ) -> Int {
        let cal = Calendar.current
        let today = cal.component(.day, from: Date())
        // 이번 달 1일 ~ 오늘까지
        var sum: Double = 0
        var count: Double = 0
        
        for day in 1...today {
            let level = achievementsByDay[day] ?? .none
            count += 1
            switch level {
            case .low:
                sum += 0.0
            case .mid:
                sum += 0.5
            case .high:
                sum += 1.0
            case .none:
                sum += 0.0
            }
        }
        guard count > 0 else { return 0 }
        return Int(round((sum / count) * 100))
    }
}
