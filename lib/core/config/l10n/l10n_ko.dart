// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class L10nKo extends L10n {
  L10nKo([String locale = 'ko']) : super(locale);

  @override
  String get next => '다음';

  @override
  String get skip => '건너뛰기';

  @override
  String get start => '시작하기';

  @override
  String get complete => '완료';

  @override
  String get edit_complete => '수정 완료';

  @override
  String get confirm_delete => '정말 삭제할까요?';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get confirm => '확인';

  @override
  String get confirm_logout => '로그아웃 하시겠습니까?';

  @override
  String get confirm_withdraw => '정말 탈퇴하시겠습니까?';

  @override
  String get withdraw_warning => '탈퇴 시 데이터가 모두 삭제되며 복구되지 않습니다.';

  @override
  String get keep_account => '유지하기';

  @override
  String get withdraw => '탈퇴하기';

  @override
  String get apple_login => 'Apple 로그인';

  @override
  String get kakao_login => 'Kakao 로그인';

  @override
  String get gogole_login => 'Google 계정으로 로그인';

  @override
  String get terms => '이용약관';

  @override
  String get policy => '개인정보처리방침';

  @override
  String agree_terms_privacy(Object terms, Object privacy) {
    return '$terms 및 $privacy에 동의합니다.';
  }

  @override
  String get intro_1_title => '오늘의 식단을\n손쉽게 기록해 보세요';

  @override
  String get intro_1_highlight => '기록';

  @override
  String get intro_2_title => '식사 알림으로\n내 건강정보를 한눈에';

  @override
  String get intro_2_highlight => '건강정보';

  @override
  String get intro_3_title => '나만의 건강 레시피를\n사람들과 공유해요';

  @override
  String get intro_3_highlight => '건강 레시피';

  @override
  String get intro_4_title => '위젯으로 식단 관리를\n더욱 더 간편하게';

  @override
  String get intro_4_highlight => '위젯';

  @override
  String get onboarding_profile => '[VitaMeal]에서 사용할\n<프로필>을 설정해주세요.';

  @override
  String get edit_profile => '[VitaMeal]에서 사용할\n<프로필>을 수정해주세요.';

  @override
  String onboarding_physical(Object name) {
    return '반갑습니다, <$name>님!\n기본 정보를 입력해주세요. (선택)';
  }

  @override
  String edit_physical(Object name) {
    return '<$name>님의\n기본 정보를 수정해주세요. (선택)';
  }

  @override
  String get onboarding_disease => '<관리가 필요한 질환>을\n모두 선택해주세요. (선택)';

  @override
  String get edit_disease => '<관리가 필요한 질환>을\n수정해주세요. (선택)';

  @override
  String get onboarding_allergy => '현재 겪고 있는 <알레르기>를\n모두 선택해주세요. (선택)';

  @override
  String get edit_allergy => '현재 겪고 있는 <알레르기>를\n수정해주세요. (선택)';

  @override
  String get member => '회원';

  @override
  String get nickname => '닉네임';

  @override
  String get nickname_example => '김비타밀';

  @override
  String get nickname_max_length => '닉네임은 10글자 이하로 입력해주세요.';

  @override
  String get enter_nickname => '닉네임을 입력해주세요.';

  @override
  String get duplicate_nickname => '이미 사용 중인 닉네임입니다.';

  @override
  String get male => '남성';

  @override
  String get female => '여성';

  @override
  String get gender => '성별';

  @override
  String get birth_year => '출생 연도';

  @override
  String get birth_year_invalid => '출생 연도는 4자리 숫자여야 해요.';

  @override
  String get birth_year_wrong => '올바른 출생 연도를 입력해주세요.';

  @override
  String get height => '키';

  @override
  String get weight => '몸무게';

  @override
  String get invalid_number => '잘못된 숫자입니다.';

  @override
  String get failed_loading_disease => '질병 목록을 불러오지 못했어요';

  @override
  String get failed_loading_allergy => '알레르기 목록을 불러오지 못했어요';

  @override
  String get welcome => '환영합니다';

  @override
  String get signup_complete => '가입이 완료되었어요';

  @override
  String get my_diet => '나의 식단';

  @override
  String get mon => '월';

  @override
  String get tue => '화';

  @override
  String get wed => '수';

  @override
  String get thu => '목';

  @override
  String get fri => '금';

  @override
  String get sat => '토';

  @override
  String get sun => '일';

  @override
  String get no_meal_record => '기록한 식단이 없어요';

  @override
  String get record_today_meal => '오늘의 식단을 기록해보세요';

  @override
  String meal_date(Object day) {
    return '$day 식단';
  }

  @override
  String get add_image => '이미지 추가';

  @override
  String get category => '분류';

  @override
  String get breakfast => '아침';

  @override
  String get lunch => '점심';

  @override
  String get dinner => '저녁';

  @override
  String get snack => '간식';

  @override
  String get description => '설명';

  @override
  String get time => '시간';

  @override
  String get select_time => '시간 선택';

  @override
  String get no_content => '내용이 없습니다';

  @override
  String get failed_to_load_data => '데이터 로드 실패';

  @override
  String get failed_to_select_image => '이미지 선택 실패';

  @override
  String get login_required => '로그인이 필요합니다';

  @override
  String get enter_image_or_content => '이미지나 식단 내용을 입력해주세요';

  @override
  String get confirm_delete_meal => '이 식단 기록을 삭제할까요?';

  @override
  String get failed_to_delete => '삭제 실패';

  @override
  String get rate_today_meal => '오늘 식단을 평가해주세요';

  @override
  String get fine => '노력해요';

  @override
  String get good => '괜찮아요';

  @override
  String get great => '최고예요';

  @override
  String get analyze => '분석하기';

  @override
  String get analyzing => '분석 중...';

  @override
  String get reanalyze => '다시 분석하기';

  @override
  String get analysis_limit => '분석은 하루 최대 3회까지 가능하며, 매일 자정에 갱신됩니다.';

  @override
  String get ai_result => 'AI 분석 결과';

  @override
  String get view_details => '자세히 보기';

  @override
  String get ai_disclaimer =>
      '본 분석은 AI가 제공하는 일반적인 건강 정보이며, 의료적 진단이나 치료를 대체하지 않습니다.';

  @override
  String get feedback => '기저질환별 피드백';

  @override
  String get key_points => '주요 포인트';

  @override
  String get suggestions => '개선 제안';

  @override
  String get source_info => '출처 및 건강 정보 관련 안내';

  @override
  String get failed_to_analyze => '분석 실패';

  @override
  String get check_connection => '네트워크 연결을 확인해주세요.';

  @override
  String get need_connection => '네트워크 연결 필요';

  @override
  String get need_connection_detail => '자세한 분석 결과를 보려면 인터넷 연결이 필요합니다.';

  @override
  String get over_analysis_limit => '오늘 분석 횟수를 모두 사용했어요';

  @override
  String get no_condition_feedback => '기저질환 피드백이 없습니다';

  @override
  String get recipe_feed => '레시피 피드';

  @override
  String get search_recipe_hint => '원하는 레시피를 검색해보세요!';

  @override
  String get no_search_result => '검색 결과가 없습니다.';

  @override
  String get saved_recipes => '저장된 레시피';

  @override
  String get favorites => '즐겨찾기';

  @override
  String get my_recipes => '나의 레시피';

  @override
  String get empty_list => '목록이 비어있습니다.';

  @override
  String get create_recipe => '레시피 작성';

  @override
  String get add_cover_image => '대표 이미지 추가';

  @override
  String get title => '제목';

  @override
  String get enter_title_hint => '제목을 입력해주세요';

  @override
  String get ingredients => '재료';

  @override
  String get enter_ingredients_hint => '재료 정보를 입력해주세요';

  @override
  String get tags => '태그';

  @override
  String get recipe_steps => '레시피 순서';

  @override
  String step_description_hint(Object step) {
    return 'Step $step 의 설명을 입력하세요';
  }

  @override
  String get add_recipe_step => '레시피 순서 추가';

  @override
  String get edit => '수정하기';

  @override
  String get delete_action => '삭제하기';

  @override
  String get edit_recipe => '레시피 수정';

  @override
  String get post_deleted => '게시글이 삭제되었습니다.';

  @override
  String get enter_title => '제목을 입력해주세요.';

  @override
  String get register_representative_image => '대표 이미지를 등록해주세요.';

  @override
  String get register_all_steps => '모든 단계의 이미지와 설명을 등록해주세요.';

  @override
  String get failed_to_load_tags => '태그 로딩 실패';

  @override
  String get failed_to_load_posts => '게시글을 불러올 수 없습니다.';

  @override
  String get cannot_bookmark_own_post => '자신의 글은 즐겨찾기 할 수 없습니다.';

  @override
  String get no_date_info => '날짜 정보 없음';

  @override
  String get anonymous_chef => '익명 요리사';

  @override
  String get eats => '건강 지도';

  @override
  String get steps => '걸음';

  @override
  String get kcal => '칼로리';

  @override
  String get need_location_perm => '위치 권한이 필요해요';

  @override
  String get request_location_perm => '지금 권한을 허용하고 내 주변 건강 음식점을 찾아보세요';

  @override
  String get allow_perm => '권한 설정';

  @override
  String get my_info => '내 정보';

  @override
  String get year_old => '세   ';

  @override
  String get failed_loading_info => '정보를 불러오지 못했어요.';

  @override
  String get health_goals => '건강 목표';

  @override
  String get no_representative_goal => '대표 설정한 목표가 없어요';

  @override
  String get recent_graph => '최근 그래프';

  @override
  String get add_data_hint => '데이터를 추가해 주세요.';

  @override
  String get goal_title => '목표명';

  @override
  String get goal_value => '목표 수치값';

  @override
  String get set_representative => '대표설정';

  @override
  String get no_goals => '등록한 목표가 없어요';

  @override
  String get add_goal => '목표 추가하기';

  @override
  String get edit_goal => '목표 수정';

  @override
  String get new_goal => '새 목표';

  @override
  String get goal_period => '목표 기간';

  @override
  String get unit => '단위';

  @override
  String get goal_amount => '목표 수치';

  @override
  String get uric_acid => '요산';

  @override
  String get date_example => 'e.g. 2000.01.01';

  @override
  String get recent_data => '최근 데이터';

  @override
  String get latest => '최신순';

  @override
  String get oldest => '오래된순';

  @override
  String get add_data => '데이터 추가';

  @override
  String get date => '일자';

  @override
  String get datetime_example => 'e.g. 2000.01.01 13:30';

  @override
  String get value => '수치';

  @override
  String get initial => '초기';

  @override
  String get current => '현재';

  @override
  String get target => '목표';

  @override
  String get goal_already_done => '이미 달성한 목표입니다!';

  @override
  String get enter_value => '수치를 입력해주세요.';

  @override
  String get set_as_representative => '대표로 설정할까요?';

  @override
  String get goal_already_achieved => '이미 달성한 목표에는 데이터를 추가할 수 없어요.';

  @override
  String get menu => '메뉴';

  @override
  String get language_setting => '언어 설정';

  @override
  String get date_setting => '날짜 설정';

  @override
  String get notification_setting => '알림 설정';

  @override
  String get logout => '로그아웃';

  @override
  String get withdraw_account => '회원 탈퇴';

  @override
  String get withdraw_error => '회원 탈퇴 중 오류가 발생했습니다.';

  @override
  String get auto_language => '언어 자동 설정';

  @override
  String get auto_date => '날짜 자동 설정';

  @override
  String get no_notifications => '등록한 알림이 없어요';

  @override
  String get add_notification => '새 알림 추가하기';

  @override
  String get notification_name => '알림 이름';

  @override
  String get breakfast_alarm => '아침 식사';

  @override
  String get enter_notification_name => '알림 이름을 입력해주세요.';

  @override
  String get need_noti_perm => '알림 권한이 필요해요';

  @override
  String get request_noti_perm => '지금 권한을 허용하고\n원하는 시간에 식사 알림을 받으세요';

  @override
  String get open_setting => '설정으로 이동';

  @override
  String get meal_tutorial_step_one => '아래로 당기면 한 달 성취도를\n한눈에 볼 수 있어요.';

  @override
  String get meal_tutorial_step_two => '버튼을 눌러서\n오늘 식단을 기록해보세요.';

  @override
  String get meal_tutorial_step_three => '식단 기록을 채우고\nAI 분석으로 나의 식습관을 확인해보세요.';

  @override
  String get meal_feedback => '식단 피드백';

  @override
  String get meal_analysis => '식단 분석';

  @override
  String get good_thing => '좋아요';

  @override
  String get bad_thing => '아쉬워요';

  @override
  String get next_step => '다음 식사에 참고해보세요';
}
