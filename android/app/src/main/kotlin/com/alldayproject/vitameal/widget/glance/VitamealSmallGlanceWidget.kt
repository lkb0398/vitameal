package com.alldayproject.vitameal.widget.glance

import android.appwidget.AppWidgetManager
import android.content.Context
import android.os.Build
import android.util.SizeF
import android.util.TypedValue
import android.widget.RemoteViews
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.LocalContext
import androidx.glance.action.clickable
import androidx.glance.appwidget.AndroidRemoteViews
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.SizeMode
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.layout.*
import androidx.glance.text.*
import com.alldayproject.vitameal.R
import com.alldayproject.vitameal.widget.data.WidgetDataLoader
import com.alldayproject.vitameal.widget.data.WidgetPrefs
import com.alldayproject.vitameal.widget.data.model.AchievementLevel
import com.alldayproject.vitameal.widget.data.model.DayCell
import com.alldayproject.vitameal.widget.data.model.WidgetCalendarData
import java.util.Locale
import android.content.Intent
import androidx.glance.appwidget.action.actionStartActivity
import com.alldayproject.vitameal.MainActivity
import kotlin.math.min
import android.app.PendingIntent
import androidx.glance.Image
import androidx.glance.ImageProvider
import com.alldayproject.vitameal.widget.style.WidgetColors
import com.alldayproject.vitameal.widget.style.WidgetStyle


class VitamealSmallGlanceWidget : GlanceAppWidget() {
    override val sizeMode: SizeMode = SizeMode.Single // 위젯을 단일크기화 (리사이즈 불가)

    /** Glance가 위젯을 그릴 때 호출되는 메인 함수 */
    override suspend fun provideGlance(context: Context, id: GlanceId) {
        // @Composable 블록으로 UI 구성
        provideContent {
            // GlanceId -> appWidgetId 변환
            // appWidgetId로 인스턴스별 WidgetPrefs 읽기 가능
            // WidgetPrefs에서 위젯 설정과 데이터 불러오기
            val appWidgetId = GlanceAppWidgetManager(context).getAppWidgetId(id)
            val style = WidgetPrefs.loadStyle(context, appWidgetId) // 위젯 스타일
            val showAdherence = WidgetPrefs.loadShowAdherence(context, appWidgetId) // 위젯 스타일
            val widgetData = WidgetDataLoader.load(context) // 위젯 데이터

            // Android 12+면 실제 위젯 크기 불러와서 레이아웃 계산에 사용
            val sideDp: Int? =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S)
                // 가로 세로중 짧은 길이 기준으로 한변 계산
                    resolveSquareSideDp(context, appWidgetId)
                else null

            val packageName = LocalContext.current.packageName

            val remoteViews = RemoteViews(packageName, R.layout.widget_frame).apply {
                // launchIntent 앱 열기 동작
                val launchIntent = context.packageManager
                    .getLaunchIntentForPackage(context.packageName)
                    ?.apply {
                        // 딥링크/URI 제거 (go_router 충돌 방지)
                        action = Intent.ACTION_MAIN
                        addCategory(Intent.CATEGORY_LAUNCHER)
                        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                        setData(null)
                    } ?: Intent(context, MainActivity::class.java).apply {
                    action = Intent.ACTION_MAIN
                    addCategory(Intent.CATEGORY_LAUNCHER)
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                    setData(null)
                }

                // requestCode를 appWidgetId로 둬서 인스턴스별 PendingIntent 충돌 방지
                // 위젯 설정페이지 위젯 인스턴스마다 다르게 해야함
                val pi = PendingIntent.getActivity(
                    context,
                    appWidgetId, // 인스턴스별 requestCode
                    launchIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                // 루트,컨테이너 둘 다 onClick 설정
                // 안드로이드는 런처별로 터치 인식하는 부분이 달라서 둘다 걸어줌
                setOnClickPendingIntent(android.R.id.background, pi)
                setOnClickPendingIntent(R.id.glance_container, pi)

                // RemoteViews 쪽에서 프레임 배경을 바꿈 (border 사용해야해서 RemoteViews와 xml 사용)
                // RemoteViews는 시스템한테 위젯의 UI를 어떻게 그려달라고 전달하는 명령서 같은거
                val borderDrawable =
                    if (style == WidgetStyle.BLACK)
                        R.drawable.bg_frame_border_black
                    else
                        R.drawable.bg_frame_border_white
                // 대상 view id , 호출할 메서드 이름 , 전달할 값
                setInt(android.R.id.background, "setBackgroundResource", borderDrawable)

                // Android 12+에서 정사각형 강제
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && sideDp != null) {
                    val side = sideDp.toFloat()

                    // 프레임
                    setViewLayoutWidth(
                        android.R.id.background,
                        side,
                        TypedValue.COMPLEX_UNIT_DIP
                    )
                    setViewLayoutHeight(
                        android.R.id.background,
                        side,
                        TypedValue.COMPLEX_UNIT_DIP
                    )

                    // 실제 콘텐츠
                    setViewLayoutWidth(
                        R.id.glance_container,
                        side,
                        TypedValue.COMPLEX_UNIT_DIP
                    )
                    setViewLayoutHeight(
                        R.id.glance_container,
                        side,
                        TypedValue.COMPLEX_UNIT_DIP
                    )
                }
            }

            // AndroidRemoteViews로 RemoteViews + Glance UI 결합
            // 이 RemoteViews 안에 있는 glance_container라는 View를, Glance UI가 차지하도록 연결해라
            //
            // RemoteViews : 위젯 프레임, 크기 강제, background 커스텀 등 위젯 툴 설정에 용이
            // Glance : 상태 분기, UI 등 구성 내용물 담당
            AndroidRemoteViews(
                remoteViews = remoteViews,
                containerViewId = R.id.glance_container,
                modifier = GlanceModifier.fillMaxSize()
            ) {
                if (widgetData == null) {
                    EmptyState(style)
                } else {
                    Content(
                        style = style,
                        showAdherence = showAdherence,
                        data = widgetData,
                        sideDp = sideDp
                    )
                }
            }
        }
    }

    /** 위젯 정사각형화를 위한 길이 계산 */
    private fun resolveSquareSideDp(context: Context, appWidgetId: Int): Int {
        val awm = AppWidgetManager.getInstance(context)
        val options = awm.getAppWidgetOptions(appWidgetId)

        // 1. Android 12+ OPTION_APPWIDGET_SIZES (Responsive sizes) 있으면 그걸 최우선
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val sizes: ArrayList<SizeF>? =
                options.getParcelableArrayList(AppWidgetManager.OPTION_APPWIDGET_SIZES)

            if (!sizes.isNullOrEmpty()) {
                // 더 짧은 변 기준으로 계산
                return sizes.maxOf { s -> min(s.width, s.height) }.toInt()
            }
        }

        // 2. 없으면 appwidget-provider의 MAX 사이즈 사용
        val maxW = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_WIDTH, 0)
        val maxH = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT, 0)
        if (maxW > 0 && maxH > 0) {
            return min(maxW, maxH)
        }

        // 3. 그것도 없으면 MIN 사이즈 사용 (110)
        val minW = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH, 110)
        val minH = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT, 110)
        return min(minW, minH)
    }

    /** Glance UI 영역에도 클릭을 걸어 앱을 열 수 있게 함
    RemoteViews에서 onClick 걸어뒀지만, Glance clickable도 걸어주는게 방어패턴 */
    @Composable
    private fun OpenAppModifier(): GlanceModifier {
        val context = LocalContext.current

        val launchIntent = Intent(context, MainActivity::class.java).apply {
            action = Intent.ACTION_MAIN
            addCategory(Intent.CATEGORY_LAUNCHER)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            data = null // 딥링크 데이터 제거
        }

        return GlanceModifier.clickable(actionStartActivity(launchIntent))
    }

    /** 위젯 화면 UI */
    @Composable
    private fun Content(
        style: String,
        showAdherence: Boolean,
        data: WidgetCalendarData,
        sideDp: Int?
    ) {
        val achievements = WidgetDataLoader.achievementsByDay(data)
        val rows = CalendarGrid.monthRowCount(data.year, data.month)
        val grid = CalendarGrid.makeMonthGrid(data.year, data.month, achievements)
        val percent = CalendarGrid.adherencePercent(achievements, data.year, data.month)

        val title = String.format(Locale.getDefault(), "%04d.%02d", data.year, data.month)

        // Android 12+에서는 정사각형으로 강제된 sideDp를 사용
        // 이하 버전은 provider 기본값 기준으로만 스케일
        val side = (sideDp ?: 110).toFloat()

        // 캘린더의 행 개수에 따른 분기 (5주, 6주)
        val titleHeightDp = if (rows == 6) 16f else 18f
        val topPaddingDp = if (rows == 6) 12f else 14f
        val gridTopGapDp = if (rows == 6) 3f else 8f
        val gridBottomPaddingDp = if (rows == 6) 8f else 12f

        // 좌우 패딩
        val titleHorizontalPadDp = 16f
        val gridHorizontalPadDp = 12f

        // 행, 열간 간격
        val rowSpacingDp = if (rows == 6) 2f else 2.5f
        val colSpacingDp = 2f

        // 그리드에 실제로 쓸 수 있는 높이
        val gridHeight =
            (side - topPaddingDp - titleHeightDp - gridTopGapDp - gridBottomPaddingDp)
                .coerceAtLeast(0f)

        // height 기준 셀 상한
        val maxCellByHeight =
            ((gridHeight - (rowSpacingDp * (rows - 1))) / rows.toFloat()).coerceAtLeast(10f)
        // width 기준 셀 상한
        val maxCellByWidth =
            ((side - (colSpacingDp * 6f) - (gridHorizontalPadDp * 2f)) / 7f).coerceAtLeast(10f)
        // 최종 셀 크기
        val cellSize = min(maxCellByHeight, maxCellByWidth).coerceAtLeast(10f)

        // 셀 모서리, 폰트 크기
        val cellRadiusDp = 6f
        val dayFontSp = 10f

        val context = LocalContext.current

        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }


        Column(modifier = GlanceModifier.fillMaxSize().then(OpenAppModifier())) {
            Spacer(GlanceModifier.height(topPaddingDp.dp))

            // --- 타이틀/달성도 ---
            Row(
                modifier = GlanceModifier
                    .fillMaxWidth()
                    .height(titleHeightDp.dp)
                    .padding(horizontal = titleHorizontalPadDp.dp),
                verticalAlignment = Alignment.Vertical.CenterVertically
            ) {
                Text(
                    text = title,
                    style = TextStyle(
                        color = WidgetColors.text(style),
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Bold
                    ),
                    maxLines = 1
                )

                Spacer(GlanceModifier.defaultWeight())

                Image(
                    provider = ImageProvider(R.drawable.ic_adherence),
                    contentDescription = null,
                    modifier = GlanceModifier
                        .size(14.dp)
                        .padding(end = 4.dp)
                )

                Text(
                    text = "${percent}%",
                    style = TextStyle(
                        color = WidgetColors.text(style),
                        fontSize = 11.sp,
                        fontWeight = FontWeight.Bold
                    )
                )
            }

            Spacer(GlanceModifier.height(gridTopGapDp.dp))

            // --- 달력 영역 ---
            Box(
                modifier = GlanceModifier
                    .fillMaxWidth()
                    .padding(horizontal = gridHorizontalPadDp.dp)
                    .padding(bottom = gridBottomPaddingDp.dp)
            ) {
                SmallGrid(
                    grid = grid,
                    rows = rows,
                    style = style,
                    cellSize = cellSize,
                    hGap = colSpacingDp,
                    vGap = rowSpacingDp,
                    cellRadius = cellRadiusDp,
                    dayFontSp = dayFontSp
                )
            }

            Spacer(GlanceModifier.height(2.dp))
        }
    }

    /** 위젯 데이터가 전달되지 않았을때 보여질 화면 */
    @Composable
    private fun EmptyState(style: String) {
        Box(
            modifier = GlanceModifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "데이터 없음",
                style = TextStyle(
                    color = WidgetColors.subText(style),
                    fontSize = 12.sp
                )
            )
        }
    }

    /** 그리드 영역 UI 구성 */
    @Composable
    private fun SmallGrid(
        grid: List<DayCell>,
        rows: Int,
        style: String,
        cellSize: Float,
        hGap: Float,
        vGap: Float,
        cellRadius: Float,
        dayFontSp: Float
    ) {
        val cells = grid.toMutableList()
        // 뒷부분 셀 빈칸 영역 채우기
        while (cells.size < rows * 7) cells.add(DayCell(null, AchievementLevel.NONE))

        Column(modifier = GlanceModifier.fillMaxWidth()) {
            var idx = 0
            repeat(rows) { r -> // 행 반복
                Row(
                    modifier = GlanceModifier
                        .fillMaxWidth()
                        .padding(bottom = if (r == rows - 1) 0.dp else vGap.dp), // 마지막행 세로간격제거
                    horizontalAlignment = Alignment.Horizontal.Start
                ) {
                    repeat(7) { c -> // 열 반복
                        val cell = cells[idx++] // 현재 셀(표현할 날짜)

                        // 간격을 주기위해, 셀을 한 번 감싸서 end padding 적용
                        // Spacer쓰면 자식 수 10개 이상으로 넘어가서 다 표현 안됨
                        // 안드로이드 위젯은 한 행에 10개 이상 구현 불가능
                        Box(
                            modifier = GlanceModifier.padding(end = if (c == 6) 0.dp else hGap.dp) // 마지막셀 0
                        ) {
                            SmallDayCell(
                                cell = cell,
                                style = style,
                                sizeDp = cellSize,
                                radiusDp = cellRadius,
                                fontSp = dayFontSp,
                                modifier = GlanceModifier
                            )
                        }
                    }
                }
            }
        }
    }

    /** 셀 UI 구현 */
    @Composable
    private fun SmallDayCell(
        cell: DayCell,
        style: String,
        sizeDp: Float,
        radiusDp: Float,
        fontSp: Float,
        modifier: GlanceModifier
    ) {
        // 빈 날짜
        if (cell.day == null) {
            Spacer(modifier.size(sizeDp.dp))
            return
        }

        // 달성도에 따른 셀 배경
        val bg = when (cell.level) {
            AchievementLevel.NONE -> null
            AchievementLevel.LOW -> WidgetColors.low
            AchievementLevel.MID -> WidgetColors.mid
            AchievementLevel.HIGH -> WidgetColors.high
        }

        Box(
            modifier = modifier
                .size(sizeDp.dp)
                .cornerRadius(radiusDp.dp)
                .let { if (bg != null) it.background(bg) else it },
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = cell.day.toString(),
                style = TextStyle(
                    color = WidgetColors.text(style),
                    fontSize = fontSp.sp
                )
            )
        }
    }
}
