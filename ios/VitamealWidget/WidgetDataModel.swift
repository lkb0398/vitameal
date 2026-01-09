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
    private let suiteName = "group.com.alldayproject.vitameal.dev"
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

    /// 특정 날짜의 성취도 조회
    func getAdherenceString(for day: Int, in data: WidgetCalendarData) -> String? {
        guard let achievementString = data.achievements["\(day)"] else {
            return nil
        }
        return achievementString // nil이면 성취도 없음
    }
}
