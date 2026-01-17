package com.alldayproject.vitameal.widget.config

import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.RadioButton
import android.widget.Switch
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.alldayproject.vitameal.R
import com.alldayproject.vitameal.widget.data.WidgetPrefs
import com.alldayproject.vitameal.widget.glance.VitamealSmallGlanceWidget
import com.alldayproject.vitameal.widget.style.WidgetStyle
import com.alldayproject.vitameal.widget.glance.updateByAppWidgetId
import kotlinx.coroutines.launch

class SmallWidgetConfigureActivity : AppCompatActivity() {

    private var appWidgetId: Int = AppWidgetManager.INVALID_APPWIDGET_ID

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 기본: 취소 처리 (유저가 뒤로가면 위젯 추가 취소)
        setResult(RESULT_CANCELED)

        setContentView(R.layout.activity_small_widget_configure)

        // 런처가 넘겨준 appWidgetId 받기
        appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish()
            return
        }

        // 현재 저장값을 UI 기본값으로 반영
        val savedStyle = WidgetPrefs.loadStyle(this, appWidgetId)
        val savedShow = WidgetPrefs.loadShowAdherence(this, appWidgetId)

        val rbBlack = findViewById<RadioButton>(R.id.rb_black)
        val rbWhite = findViewById<RadioButton>(R.id.rb_white)
        val sw = findViewById<Switch>(R.id.sw_adherence)
        val btn = findViewById<Button>(R.id.btn_done)

        if (savedStyle == WidgetStyle.BLACK) rbBlack.isChecked = true else rbWhite.isChecked = true
        sw.isChecked = savedShow

        btn.setOnClickListener {
            val newStyle = if (rbBlack.isChecked) WidgetStyle.BLACK else WidgetStyle.WHITE
            val newShow = sw.isChecked

            // ✅ 인스턴스별 저장
            WidgetPrefs.saveStyle(this, appWidgetId, newStyle)
            WidgetPrefs.saveShowAdherence(this, appWidgetId, newShow)

            // ✅ 해당 위젯 인스턴스만 업데이트 (핵심)
            lifecycleScope.launch {
                VitamealSmallGlanceWidget().updateByAppWidgetId(this@SmallWidgetConfigureActivity, appWidgetId)
                finishSuccess()
            }
        }
    }

    private fun finishSuccess() {
        val resultValue = Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
        setResult(RESULT_OK, resultValue)
        finish()
    }
}
