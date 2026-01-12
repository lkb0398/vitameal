import Flutter
import UIKit
import WidgetKit

@main // main: Flutter 앱의 iOS 진입점
@objc class AppDelegate: FlutterAppDelegate { // FlutterAppDelegate: Flutter 엔진을 iOS 앱 생명주기와 연결
    override func application(
        _ application: UIApplication,
        // didFinishLaunchingWithOptions: iOS 앱이 실행될 때 가장 먼저 호출되는 메서드
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Flutter 플러그인 자동 등록: SharedPreference 등 Flutter 플러그인을 사용 가능하도록 함
        GeneratedPluginRegistrant.register(with: self)
        
        // Method Channel 설정
        setupMethodChannel()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    /// Flutter에서 위젯 데이터 업데이트 요청
    private func setupMethodChannel() {
        // Flutter 화면 컨트롤러 획득
        // MethodChannel은 반드시 FlutterViewController의 binaryMessenger를 사용해야 함
        guard let controller = window?.rootViewController as? FlutterViewController else {
            return
        }
        // MethodChannel 생성: Flutter의 WidgetBridge에서 같은 채널 명으로 호출해야 함
        let channel = FlutterMethodChannel(
            name: "com.alldayproject.vitameal.dev/widget",
            binaryMessenger: controller.binaryMessenger
        )
        // 메서드 호출 핸들러 등록: Flutter → iOS 호출이 들어올 때 실행됨
        // Flutter의 WidgetBridge에서 정의한 메서드들 다루기
        channel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "updateWidgetData":
                self?.handleUpdateWidgetData(call: call, result: result)
            case "reloadWidget":
                self?.handleReloadWidget(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    /// Flutter에서 위젯 데이터 업데이트 요청
    private func handleUpdateWidgetData(call: FlutterMethodCall, result: @escaping FlutterResult) {
        // Flutter에서 전달된 데이터 파싱
        guard let args = call.arguments as? [String: Any],
              let jsonString = args["data"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid data", details: nil))
            return
        }
        
        // App Group의 UserDefaults에 저장
        if let userDefaults = UserDefaults(suiteName: "group.com.alldayproject.vitameal.dev") {
            // JSON 문자열을 그대로 저장, 위젯에서 이 키를 읽어서 UI 구성
            userDefaults.set(jsonString, forKey: "widgetCalendarData")
            userDefaults.synchronize()
            
            // 위젯 새로고침
            // 모든 위젯 타임라인을 즉시 다시 로드함, 데이터 변경 후 반드시 필요
            WidgetCenter.shared.reloadAllTimelines()
            
            result(true)
        } else {
            result(FlutterError(code: "USERDEFAULTS_ERROR", message: "Cannot access App Group", details: nil))
        }
    }
    
    /// 위젯 강제 새로고침
    private func handleReloadWidget(result: @escaping FlutterResult) {
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
        result(true)
    }
}
