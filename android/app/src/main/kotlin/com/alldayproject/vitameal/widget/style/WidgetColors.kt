package com.alldayproject.vitameal.widget.style

import androidx.glance.color.ColorProvider
import androidx.compose.ui.graphics.Color

object WidgetColors {
    // 삼색 파레트
    val low = ColorProvider(day= Color(0xDDFF6B6B), night = Color(0xDDFF6B6B))
    val mid = ColorProvider(day = Color(0xDDFFD93D), night = Color(0xDDFFD93D))
    val high = ColorProvider(day = Color(0xDD6BCB77), night = Color(0xDD6BCB77))

    // 초록 파레트
    val lowG  = ColorProvider(day = Color(0xDDE9FAC8), night = Color(0xDDE9FAC8))
    val midG  = ColorProvider(day = Color(0xDDD2F291), night = Color(0xDDD2F291))
    val highG = ColorProvider(day = Color(0xDDB8E55C), night = Color(0xDDB8E55C))

    fun cellLow(palette: String) =
        if (palette == WidgetPaletteStyle.GREENS) lowG else low
    fun cellMid(palette: String) =
        if (palette == WidgetPaletteStyle.GREENS) midG else mid
    fun cellHigh(palette: String) =
        if (palette == WidgetPaletteStyle.GREENS) highG else high

    fun text(style: String) = if (style == "white") {
        ColorProvider(day = Color.White, night = Color.White)
    } else {
        ColorProvider(day = Color(0xFF111111), night = Color(0xFF111111))
    }

    fun subText(style: String) = if (style == "white") {
        ColorProvider(day = Color(0xCCFFFFFF), night = Color(0xCCFFFFFF))
    } else {
        ColorProvider(day = Color(0x99111111), night = Color(0x99111111))
    }
}