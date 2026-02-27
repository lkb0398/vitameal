package com.alldayproject.vitameal

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import com.alldayproject.vitameal.widget.update.WidgetUpdateRunner
import com.alldayproject.vitameal.widget.data.WidgetPrefs
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.launch
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob

// main은 네이티브 위젯과 플러터 간의 브릿지 역할. IOS의 AppDelegate 느낌.
// 메서드 패널을 통해 데이터를 전달받고 위젯을 업데이트한다
// Flutter에서 전달한 JSON 데이터를 저장 -> Glance 위젯들을 갱신

class MainActivity : FlutterActivity() {
    // 위젯 업데이트용 코루틴 스코프, 업데이트가 잘 안되서 백그라운드로 해봄
    private val widgetUpdateScope = CoroutineScope(SupervisorJob() + Dispatchers.Default)
    private val channelName = "com.alldayproject.vitameal/widget"

    // 앱이 종료된 상태로 위젯 클릭시
    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        // Glance Intent 정리
        // Glance 위젯 클릭시 android는 딥링크 인텐트를 앱으로 보내는데
        // 플러터에서 go_router를 쓰고있으면 라우트로 오인해서, 잘못된 네비게이션 유발
        // 그래서 플러터 엔진이 뜨기 전에 처리해야함
        sanitizeGlanceIntentIfNeeded()
        super.onCreate(savedInstanceState)
    }

    // 앱이 이미 실행 중일 때 위젯 클릭시
    // (백그라운드에서 살아있을 때 위젯 클릭해서 딥링크 인텐트 호출되는경우)
    override fun onNewIntent(intent: Intent) {
        setIntent(intent)
        sanitizeGlanceIntentIfNeeded()
        super.onNewIntent(intent)
    }

    private fun sanitizeGlanceIntentIfNeeded() {
        val i = intent ?: return
        val d = i.dataString ?: return

        // Glance callback 딥링크면 Flutter(go_router)로 넘기지 않게 제거
        if (d.startsWith("glance-action:")) {
            i.data = null
            // 일반 앱 실행 인텐트로 전환
            i.action = Intent.ACTION_MAIN
            i.addCategory(Intent.CATEGORY_LAUNCHER)
        }
    }

    /** Flutter 엔진이 초기화될 때 호출, 여기서 메서드 채널 등록 */
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // 플러터에서 메서드 채널을 통해 호출한 메서드를 다룬다
        // 메서드는 플러터의 WidgetBridge 메서드들과 대응
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateWidgetData" -> {
                        // 플러터에서 전달한 JSON
                        val args = call.arguments as? Map<*, *>
                        val jsonString = args?.get("data") as? String
                        if (jsonString.isNullOrBlank()) {
                            result.error("INVALID_ARGUMENT", "Invalid data", null)
                            return@setMethodCallHandler
                        }

                        // SharedPreferences에 저장
                        // 위젯에서는 이 데이터를 읽어서 UI를 갱신함
                        WidgetPrefs.saveCalendarJson(this, jsonString)

                        // 위젯 갱신
                        WidgetUpdateRunner.forceUpdateSmall(applicationContext)
                        result.success(true)
                    }

                    // 데이터 강제 새로고침
                    "reloadWidget" -> {
                        widgetUpdateScope.launch {
                            WidgetUpdateRunner.forceUpdateSmall(applicationContext)
                        }
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }
    }
}