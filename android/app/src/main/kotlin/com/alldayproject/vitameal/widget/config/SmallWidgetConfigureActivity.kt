package com.alldayproject.vitameal.widget.config

import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.SeekBar
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.alldayproject.vitameal.R
import com.alldayproject.vitameal.databinding.ActivitySmallWidgetConfigureBinding
import com.alldayproject.vitameal.widget.data.WidgetPrefs
import com.alldayproject.vitameal.widget.glance.VitamealSmallGlanceWidget
import com.alldayproject.vitameal.widget.glance.updateByAppWidgetId
import com.alldayproject.vitameal.widget.style.WidgetFontAndBorderStyle
import com.alldayproject.vitameal.widget.style.WidgetPaletteStyle
import com.alldayproject.vitameal.widget.update.WidgetUpdateRunner
import kotlinx.coroutines.launch

class SmallWidgetConfigureActivity : AppCompatActivity() {

    private var appWidgetId: Int = AppWidgetManager.INVALID_APPWIDGET_ID
    private lateinit var binding: ActivitySmallWidgetConfigureBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setResult(RESULT_CANCELED) // 기본 취소, 저장시에만 RESULT_OK

        binding = ActivitySmallWidgetConfigureBinding.inflate(layoutInflater)
        setContentView(binding.root)

        appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish()
            return
        }

        // 위젯 스타일 불러오기
        val savedStyle = WidgetPrefs.loadStyle(this, appWidgetId)
        val savedOpacity = WidgetPrefs.loadBorderOpacity(this, appWidgetId)
        val savedShowAdherence = WidgetPrefs.loadShowAdherence(this, appWidgetId)
        val savedPalette = WidgetPrefs.loadPalette(this, appWidgetId)

        // 다크모드 (위젯 텍스트, 테두리)
        binding.swDark.isChecked = (savedStyle == WidgetFontAndBorderStyle.WHITE)

        // 테두리 투명도
        binding.sbOpacity.progress = savedOpacity
        binding.tvOpacity.text = savedOpacity.toString()

        // 셀 색상 파레트
        binding.swPalette.isChecked =
            savedPalette == WidgetPaletteStyle.GREENS

        // 달성도 표시
        binding.swAdherence.isChecked = savedShowAdherence

        // seekbar 리스너
        binding.sbOpacity.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                binding.tvOpacity.text = progress.toString()
            }
            override fun onStartTrackingTouch(seekBar: SeekBar?) {}
            override fun onStopTrackingTouch(seekBar: SeekBar?) {}
        })

        // 취소 버튼 리스너
        binding.btnCancel.setOnClickListener {
            finish()
        }

        // 저장 버튼 리스너
        binding.btnSave.setOnClickListener {
            val newStyle = if (binding.swDark.isChecked) WidgetFontAndBorderStyle.WHITE else WidgetFontAndBorderStyle.BLACK
            val newOpacity = binding.sbOpacity.progress
            val newPalette = if (binding.swPalette.isChecked) WidgetPaletteStyle.GREENS else WidgetPaletteStyle.RYG
            val newShowAdherence = binding.swAdherence.isChecked

            // 저장
            WidgetPrefs.saveStyle(this, appWidgetId, newStyle)
            WidgetPrefs.saveBorderOpacity(this, appWidgetId, newOpacity)
            WidgetPrefs.savePalette(this, appWidgetId, newPalette)
            WidgetPrefs.saveShowAdherence(this, appWidgetId, newShowAdherence)

            // 갱신
            lifecycleScope.launch {
                WidgetUpdateRunner.forceUpdateSmall(applicationContext)
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
