<h1 align="center">
Vitameal
</h1>
<p align="center">
  <img alt="mockup" src="./assets/images/read_me_intro.png"/>
</p>

<br/>

## <img width="24" height="20" alt="App_icon_48_40" src="https://github.com/user-attachments/assets/a6bff239-f3a2-4b15-990c-782e4e9d008d" /> 프로젝트 개요
### 식단 기록, 건강 관리를 위한 Android/iOS 앱 서비스
- 사용자의 건강 상태와 식습관을 바탕으로 최적의 영양 상태를 유지할 수 있도록 돕는 스마트 헬스케어 플랫폼입니다.
- 개인화된 데이터를 기반으로 한 식단 관리 & 건강 관리 서비스 제공을 목표로 합니다.
- 오늘 먹은 식단을 기록하고, 나만의 건강 목표를 세워 관리해보세요.

<br/>  

## 📌 주요 기능
### 식단 기록 및 자가 평가 & AI 영양 피드백
     - 하루의 식단을 기록하고 스스로 평가할 수 있어요.
     - 기록의 추이를 한눈에 볼 수 있어요.
     - AI가 내 건강정보를 반영한 질병 맞춤 식단 피드백을 제공해요.
     - 식단의 개선 포인트를 확인할 수 있어요.
    
### 건강 목표 설정 & 데이터 그래프 관리
     - 나만의 건강 목표를 설정할 수 있어요.
     - 목표에 필요한 데이터 수치를 직접 기록해 그래프로 추적할 수 있어요.
     - 변화 흐름을 보며 꾸준한 관리 루틴을 만들 수 있어요.
      
### 건강 레시피 피드
     - 내가 만든 건강 레시피를 등록하고 다른 사용자와 공유할 수 있어요.
     - 즐겨찾기로 자주 보는 레시피를 모을 수 있어요.
     - 내가 작성한 레시피를 관리할 수 있어요.
      
### 홈 화면 위젯
     - 기록의 추이와 달성률을 캘린더 형태로 홈 화면에 배치할 수 있어요.
     - 앱을 열지 않아도 기록을 빠르게 확인할 수 있어요.
      
### 건강 지도
     - 지도를 통해 카테고리 별 가까운 건강 식당을 찾을 수 있어요.
     - 만보기 기능을 제공해요.

<br/>     

## 🎨 앱 디자인 설계
<p align="center">
  <img alt="design" src="./assets/images/rm_design1.jpeg"/>
</p>
<p align="center">
  <img alt="design" src="./assets/images/rm_design2.jpeg"/>
</p>
<p align="center">
  <img alt="design" src="./assets/images/rm_design3.jpeg"/>
</p>
<p align="center">
  <img alt="design" src="./assets/images/rm_design4.jpeg"/>
</p>

<br/>

## 🛠️ 기술 스택

### 🏗️ Architecture & Language
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **Framework** | Flutter | 크로스플랫폼 프레임워크 |
| **Language** | Dart | 프로그래밍 언어 |
| **Architecture** | Clean Architecture | 의존성 분리, 도메인 중심 설계 |

### 🧩 State Management & Logic
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **State Management** | Riverpod | 전역 상태 관리, DI |
| **Hooks** | flutter_hooks | 위젯 생명주기 관리 및 로직 간결화 |
| **Data Modeling** | freezed | Immutable 데이터 모델링 및 Union types |
| **Serialization** | json_serializable | API/DB 데이터 직렬화 자동화 |

### 🌐 Backend & Database
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **Backend (BaaS)** | Supabase | Auth(OAuth), PostgreSQL, Storage, RPC 서버 로직 |
| **Local DB** | Drift (SQLite) | 로컬 SQLite DB 추상화 및 오프라인 데이터 관리 |
| **Storage** | shared_preferences | 언어 설정 및 간단한 사용자 설정 저장 |
| **File System** | path_provider | 로컬 파일 경로 관리 및 sqlite3_flutter_libs 지원 |

### 📍 Navigation & Localization
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **Routing** | go_router | 선언형 라우팅 및 인증 상태 기반 화면 분기 |
| **Localization** | intl / ARB | ARB 기반 다국어 지원 (앱 재시작 없이 즉시 반영) |
| **System** | url_launcher | 외부 링크 및 출처 페이지 연결 |

### 📱 Device & Sensor 
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **Location** | geolocator | GPS 기반 위치 정보 조회 및 권한 처리 |
| **Map** | intl / google_maps_flutter | 지도 렌더링 및 위치 시각화 |
| **Activity Tracking** | pedometer | 걸음 수 및 사용자 활동 데이터 수집 |
| **Permission** | permission_handler | 위치, 센서 등 런타임 권한 관리 |

### 🔔 Firebase & Infrastructure
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **Push Notification** | firebase_messaging | FCM 푸시 알림 (Foreground / Background) |
| **Local Notify** | flutter_local_notifications | 로컬 알림 처리 |
| **Analytics** | Firebase Analytics | 사용자 행동 분석 및 이벤트 트래킹 |
| **Crash Report** | Firebase Crashlytics | 런타임 크래시 수집 및 분석 |

### 🎨 UI/UX & Media
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **Visualization** | fl_chart | 건강 데이터 시각화를 위한 그래프 |
| **Calendar** | table_calendar | 캘린더 UI 구현 |
| **Image Process** | image_picker / compress | 이미지 선택 및 업로드 전 압축 최적화 |
| **Image Cache** | cached_network_image | 네트워크 이미지 캐싱 성능 개선 |
| **Icons** | flutter_svg / phosphor_flutter | SVG 및 포스포 아이콘 라이브러리 |
| **Components** | dropdown_button2 / slidable | 커스텀 드롭다운 및 스와이프 액션 UI |
| **Anti-Spam** | tap_debouncer | 버튼 중복 클릭 방지 |
| **Onboarding** | tutorial_coach_mark | 기능 안내 온보딩 오버레이 |
| **Anti-Spam** | tap_debouncer | 버튼 중복 클릭 방지 |

### 🤖 AI & Others
| 분류 | 기술 | 상세 설명 |
| :--- | :--- | :--- |
| **AI** | OpenAI API | 기저질환 반영 AI 식단 분석 |
| **Social Auth** | Kakao SDK / Web Auth 2 | 카카오 로그인 및 OAuth 인증 지원 |
| **Home Widget** | home_widget | iOS / Android 홈 위젯 데이터 연동 |
| **Environment** | flutter_dotenv | 환경변수(.env) 관리 |
| **Build Tool** | build_runner | 코드 생성 자동화 및 flutter_native_splash |

<br/>

## 📖 라이브러리

<pre>
<h3>dependencies:</h3>
  flutter_hooks: ^0.21.3+1
  freezed_annotation: ^3.1.0
  hooks_riverpod: ^3.0.3
  json_annotation: ^4.9.0
  riverpod_annotation: ^3.0.3
  flutter_riverpod: ^3.0.3
  build_runner: ^2.7.1
  go_router: ^17.0.0
  intl: ^0.20.2
  image_picker: ^1.2.1
  supabase_flutter: ^2.12.0
  tap_debouncer: ^2.2.0
  table_calendar: ^3.2.0
  fl_chart: ^1.1.1
  shared_preferences: ^2.5.4
  flutter_image_compress: ^2.4.0
  connectivity_plus: ^7.0.0
  drift: ^2.25.0
  sqlite3_flutter_libs: ^0.5.41
  path_provider: ^2.1.5
  path: ^1.9.1
  uuid: ^4.5.2
  flutter_slidable: ^4.0.3
  firebase_core: ^4.3.0
  firebase_messaging: ^16.1.0
  flutter_local_notifications: ^19.5.0
  flutter_svg: ^2.2.3
  dropdown_button2: ^2.3.9
  home_widget: ^0.8.1
  phosphor_flutter: ^2.1.0
  cached_network_image: ^3.4.1
  firebase_crashlytics: ^5.0.6
  firebase_analytics: ^12.1.0
  url_launcher: ^6.3.2
  kakao_flutter_sdk_user: ^1.10.0
  flutter_dotenv: ^6.0.0
  flutter_web_auth_2: ^5.0.0
  tutorial_coach_mark: ^1.3.3
  google_maps_flutter: ^2.16.0
  geolocator: ^14.0.2
  pedometer: ^4.2.0
  permission_handler: ^12.0.1
  scrollable_positioned_list: ^0.3.8

<h3>dev_dependencies:</h3>
  flutter_test:
    sdk: flutter
  freezed: ^3.2.3
  flutter_lints: ^5.0.0
  json_serializable: ^6.11.2
  riverpod_generator: ^3.0.3
  change_app_package_name: ^1.5.0
  drift_dev: ^2.25.0
  flutter_native_splash: ^2.4.7
</pre>

<br/>

## 📂 프로젝트 구조
<pre>
vitameal/
├── .vscode/
│   └── extensions.json
├── android/
│   ├── app/
│   │   ├── google-services.json
│   │   ├── build.gradle.kts
│   │   └── src/main/kotlin/com/alldayproject/vitameal/
│   │       ├── MainActivity.kt
│   │       └── widget/ (Android Widget 구현부)
│   └── ... (안드로이드 리소스 및 설정 파일들)
├── ios/
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── GoogleService-Info.plist
│   │   └── Info.plist
│   ├── VitamealWidget/ (iOS Widget 구현부)
│   └── Podfile
├── assets/
│   └── images/ (앱 로고, 인트로, 스플래시 이미지 등)
├── lib/
│   ├── main.dart
│   ├── core/ (공통 모듈 및 설정)
│   │   ├── config/ (Router, Firebase 설정)
│   │   ├── di/ (Riverpod Provider)
│   │   ├── platform/ (Native Bridge)
│   │   ├── service/ (FCM, Analytics, Notification)
│   │   ├── theme/ (App Theme, Colors)
│   │   └── util/ (Common Utils)
│   ├── data/ (데이터 계층)
│   │   ├── data_source/ (Remote/Local Data Source)
│   │   ├── database/ (Drift DB & DAO)
│   │   ├── dto/ (Data Transfer Objects & Freezed)
│   │   ├── mapper/ (DTO <-> Entity 매퍼)
│   │   ├── repository_impl/ (Repository 구현체)
│   │   ├── service/ (Sync, Widget Service)
│   │   └── util/ (Image Compressor 등)
│   ├── domain/ (비즈니스 로직 계층)
│   │   ├── entity/ (Domain Models)
│   │   ├── enum/ (Common Enums)
│   │   ├── repository/ (Repository 인터페이스)
│   │   └── usecase/ (Business Logic)
│   └── presentation/ (UI 계층)
│       ├── auth/ (로그인 및 소셜 인증)
│       ├── date_notation/ (날짜 표기 설정)
│       ├── eats/ (건강지도)
│       ├── goal/ (목표 설정 및 관리)
│       ├── home/ (메인 홈 화면)
│       ├── info/ (분석 그래프 및 정보)
│       ├── intro/ (온보딩/인트로 화면)
│       ├── language/ (언어설정)
│       ├── meal_calendar/ (식단 달력 및 AI 분석 결과)
│       ├── meal_editor/ (식단 추가/수정)
│       ├── notification/ (알림 목록 및 설정)
│       ├── onboarding/ (사용자 정보 입력 단계)
│       ├── post/ (게시글 및 레시피 공유)
│       ├── setting/ (앱 설정 및 메뉴)
│       ├── splash/ (스플래시 화면)
│       ├── ui_provider/ (UI 용 Riverpod Providers)
│       ├── util/ (UI Utils & Snackbar)
│       └── widget/ (공통 UI 컴포넌트 - 버튼, 다이얼로그 등)
├── supabase/
│   ├── functions/ (Edge Functions)
│   │   ├── analyze-meals/ (AI 식단 분석)
│   │   └── send_fcm_notification/ (알림 발송)
│   └── config.toml
├── .env (환경 변수)
├── analysis_options.yaml (린트 설정)
├── firebase.json (Firebase 설정)
├── flutter_launcher_icons.yaml (아이콘 설정)
├── pubspec.yaml (의존성 관리)
└── README.md
</pre>

<br/>

## 📝 커밋 컨벤션

- feat: 새로운 기능 추가
- fix: 버그 수정
- docs: 문서 수정
- style: 코드 포맷팅, 세미콜론 누락 등
- refactor: 코드 리팩터링
- design: 사용자 UI 디자인 변경
- test: 테스트 코드 추가
- chore: 빌드, 패키지 매니저 등 환경 설정
