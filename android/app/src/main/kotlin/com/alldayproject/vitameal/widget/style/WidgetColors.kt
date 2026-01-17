package com.alldayproject.vitameal.widget.style

import androidx.glance.color.ColorProvider
import androidx.compose.ui.graphics.Color

object WidgetColors {
    val low = ColorProvider(day= Color(0xDDFF6B6B), night = Color(0xDDFF6B6B))
    val mid = ColorProvider(day = Color(0xDDFFD93D), night = Color(0xDDFFD93D))
    val high = ColorProvider(day = Color(0xDD6BCB77), night = Color(0xDD6BCB77))

    fun text(style: String) = if (style == "white") {
        ColorProvider(day = Color.White, night = Color.White)
    } else {
        ColorProvider(day = Color(0xFF111111), night = Color(0xFF111111))
    }

    fun border(style: String) = if (style == "white") {
        ColorProvider(day = Color(0xB3FFFFFF), night = Color(0xB3FFFFFF))
    } else {
        ColorProvider(day = Color(0xB3000000), night = Color(0xB3000000))
    }

    fun subText(style: String) = if (style == "white") {
        ColorProvider(day = Color(0xCCFFFFFF), night = Color(0xCCFFFFFF))
    } else {
        ColorProvider(day = Color(0x99000000), night = Color(0x99000000))
    }
}