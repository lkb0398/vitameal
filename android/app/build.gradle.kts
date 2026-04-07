import java.util.Properties

// key.properties 로딩
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}

// plugins 적용
plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("org.jetbrains.kotlin.plugin.serialization")
    // Kotlin 2.x 계열에서 Compose 관련 설정을 활성화
    id("org.jetbrains.kotlin.plugin.compose")
}

android {
    namespace = "com.alldayproject.vitameal"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // 릴리즈 서명 설정
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }

    // Kotlin 2.x + Compose에서는 buildFeatures.compose 활성화 필요
    buildFeatures {
        compose = true
        viewBinding = true
    }

    // 앱 기본 정보
    defaultConfig {
        applicationId = "com.alldayproject.vitameal"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // 릴리즈 빌드 설정
    buildTypes {
        release {
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation("androidx.appcompat:appcompat:1.7.1")
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.constraintlayout:constraintlayout:2.2.1")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("com.google.android.gms:play-services-auth:21.0.0")
    /**
     * Compose 버전 혼재(runtime 1.7.8 vs ui 1.6.8)를 없애기 위해 BOM으로 정렬.
     * compose-bom:2024.11.00이 compose 1.7.8 라인을 포함합니다.
     */
    implementation(platform("androidx.compose:compose-bom:2024.11.00"))
    implementation("androidx.compose.runtime:runtime")
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-unit")
    implementation("androidx.compose.ui:ui-graphics")

    // Glance
    implementation("androidx.glance:glance-appwidget:1.1.1")
    implementation("androidx.glance:glance-material3:1.1.1")

    // Kotlinx serialization
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.7.3")

    // Glance 버전 고정
    constraints {
        implementation("androidx.glance:glance-appwidget") {
            version { strictly("1.1.1") }
        }
        implementation("androidx.glance:glance-material3") {
            version { strictly("1.1.1") }
        }
        implementation("androidx.glance:glance") {
            version { strictly("1.1.1") }
        }
    }
}

flutter {
    source = "../.."
}