// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get start => 'Get Started';

  @override
  String get complete => 'Done';

  @override
  String get edit_complete => 'Save Changes';

  @override
  String get confirm_delete => 'Are you sure you want to delete?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirm_logout => 'Do you want to log out?';

  @override
  String get confirm_withdraw => 'Do you want to delete your account?';

  @override
  String get withdraw_warning =>
      'All data will be permanently deleted and cannot be restored.';

  @override
  String get keep_account => 'Keep Account';

  @override
  String get withdraw => 'Delete Account';

  @override
  String get apple_login => 'Sign in with Apple';

  @override
  String get kakao_login => 'Sign in with Kakao';

  @override
  String get gogole_login => 'Sign in with Google';

  @override
  String get terms => 'Terms of Service';

  @override
  String get policy => 'Privacy Policy';

  @override
  String agree_terms_privacy(Object terms, Object privacy) {
    return 'I agree to the $terms and $privacy.';
  }

  @override
  String get intro_1_title => 'Easily record\nyour meals every day';

  @override
  String get intro_1_highlight => 'record';

  @override
  String get intro_2_title =>
      'See your health info\nat a glance with meal reminders';

  @override
  String get intro_2_highlight => 'health info';

  @override
  String get intro_3_title => 'Share your healthy recipes\nwith others';

  @override
  String get intro_3_highlight => 'healthy recipes';

  @override
  String get intro_4_title => 'Manage meals more easily\nwith widgets';

  @override
  String get intro_4_highlight => 'widgets';

  @override
  String get onboarding_profile => 'Set up your <profile>\non [VitaMeal].';

  @override
  String get edit_profile => 'Edit your <profile>\non [VitaMeal].';

  @override
  String onboarding_physical(Object name) {
    return 'Welcome, <$name>!\nEnter your basic information.\n(Optional)';
  }

  @override
  String edit_physical(Object name) {
    return '<$name>,\nEdit your basic information\n(Optional)';
  }

  @override
  String get onboarding_disease =>
      '<Health conditions to manage>\nSelect all that apply. (Optional)';

  @override
  String get edit_disease =>
      '<Health conditions to manage>\nEdit your selection. (Optional)';

  @override
  String get onboarding_allergy =>
      'Current <food allergies>\nSelect all that apply. (Optional)';

  @override
  String get edit_allergy =>
      'Current <food allergies>\nEdit your selection. (Optional)';

  @override
  String get member => 'member';

  @override
  String get nickname => 'Nickname';

  @override
  String get nickname_example => 'Vitameal';

  @override
  String get nickname_max_length => 'Nickname must be 10 characters or less.';

  @override
  String get enter_nickname => 'Please enter a nickname.';

  @override
  String get duplicate_nickname => 'This nickname is already taken.';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get gender => 'Gender';

  @override
  String get birth_year => 'Birth Year';

  @override
  String get birth_year_invalid => 'Birth year must be a 4-digit number.';

  @override
  String get birth_year_wrong => 'Please enter a valid birth year.';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get invalid_number => 'Invalid number.';

  @override
  String get failed_loading_disease => 'Failed to load the disease list.';

  @override
  String get failed_loading_allergy => 'Failed to load the allergy list.';

  @override
  String get welcome => 'Welcome';

  @override
  String get signup_complete => 'Your signup is complete.';

  @override
  String get my_diet => 'Diet';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get sat => 'Sat';

  @override
  String get sun => 'Sun';

  @override
  String get no_meal_record => 'No meal records yet';

  @override
  String get record_today_meal => 'Record today’s meal';

  @override
  String meal_date(Object day) {
    return 'Meals on $day';
  }

  @override
  String get add_image => 'Add Image';

  @override
  String get category => 'Category';

  @override
  String get breakfast => 'Breakfast';

  @override
  String get lunch => 'Lunch';

  @override
  String get dinner => 'Dinner';

  @override
  String get snack => 'Snack';

  @override
  String get description => 'Description';

  @override
  String get time => 'Time';

  @override
  String get select_time => 'Select Time';

  @override
  String get no_content => 'No content';

  @override
  String get failed_to_load_data => 'Failed to load data.';

  @override
  String get failed_to_select_image => 'Failed to select image.';

  @override
  String get login_required => 'Please log in to continue.';

  @override
  String get enter_image_or_content => 'Please add an image or meal details.';

  @override
  String get confirm_delete_meal => 'Delete this meal record?';

  @override
  String get failed_to_delete => 'Failed to delete.';

  @override
  String get rate_today_meal => 'How was today’s meal?';

  @override
  String get fine => 'Fine';

  @override
  String get good => 'Good';

  @override
  String get great => 'Great';

  @override
  String get analyze => 'Analyze';

  @override
  String get analyzing => 'Analyzing...';

  @override
  String get reanalyze => 'Analyze Again';

  @override
  String get analysis_limit =>
      'Analysis is limited to 3 times per day and resets at midnight.';

  @override
  String get ai_result => 'AI Analysis Result';

  @override
  String get view_details => 'View Details';

  @override
  String get ai_disclaimer =>
      'This analysis provides general health information and does not replace medical advice.';

  @override
  String get feedback => 'Feedback by\nmedical condition';

  @override
  String get key_points => 'Key Points';

  @override
  String get suggestions => 'Suggestions';

  @override
  String get source_info => 'Sources & Health Information';

  @override
  String get failed_to_analyze => 'Analysis failed';

  @override
  String get check_connection => 'Please check your internet connection.';

  @override
  String get need_connection => 'Internet Connection Required';

  @override
  String get need_connection_detail =>
      'An internet connection is required to view detailed analysis results.';

  @override
  String get over_analysis_limit =>
      'You\'ve reached your daily analysis limit.';

  @override
  String get no_condition_feedback => 'No condition feedback.';

  @override
  String get recipe_feed => 'Recipe';

  @override
  String get search_recipe_hint => 'Search for recipes you like!';

  @override
  String get no_search_result => 'No results found.';

  @override
  String get saved_recipes => 'Saved Recipes';

  @override
  String get favorites => 'Favorites';

  @override
  String get my_recipes => 'My Recipes';

  @override
  String get empty_list => 'The list is empty.';

  @override
  String get create_recipe => 'Create Recipe';

  @override
  String get add_cover_image => 'Add Cover Image';

  @override
  String get title => 'Title';

  @override
  String get enter_title_hint => 'Enter a title';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get enter_ingredients_hint => 'Enter ingredient details';

  @override
  String get tags => 'Tags';

  @override
  String get recipe_steps => 'Recipe Steps';

  @override
  String step_description_hint(Object step) {
    return 'Enter description for\nStep $step';
  }

  @override
  String get add_recipe_step => 'Add Step';

  @override
  String get edit => 'Edit';

  @override
  String get delete_action => 'Delete';

  @override
  String get edit_recipe => 'Edit Recipe';

  @override
  String get post_deleted => 'The post has been deleted.';

  @override
  String get enter_title => 'Please enter a title.';

  @override
  String get register_representative_image => 'Please add a cover image.';

  @override
  String get register_all_steps =>
      'Please add images and descriptions for all steps.';

  @override
  String get failed_to_load_tags => 'Failed to load tags';

  @override
  String get failed_to_load_posts => 'Unable to load posts.';

  @override
  String get cannot_bookmark_own_post => 'You can\'t bookmark your own post.';

  @override
  String get no_date_info => 'No date available.';

  @override
  String get anonymous_chef => 'Anonymous Chef';

  @override
  String get eats => 'Eats';

  @override
  String get steps => 'steps';

  @override
  String get kcal => 'kcal';

  @override
  String get need_location_perm => 'Enable location permission';

  @override
  String get request_location_perm => 'to discover healthy restaurants nearby';

  @override
  String get allow_perm => 'Allow Permission';

  @override
  String get my_info => 'My Info';

  @override
  String get year_old => '   ';

  @override
  String get failed_loading_info => 'Failed to load the info.';

  @override
  String get health_goals => 'Health Goals';

  @override
  String get no_representative_goal => 'No primary goal set';

  @override
  String get recent_graph => 'Recent Graph';

  @override
  String get add_data_hint => 'Please add data.';

  @override
  String get goal_title => 'Title';

  @override
  String get goal_value => 'Target Value';

  @override
  String get set_representative => 'Primary';

  @override
  String get no_goals => 'No goals registered';

  @override
  String get add_goal => 'Add Goal';

  @override
  String get edit_goal => 'Edit Goal';

  @override
  String get new_goal => 'New Goal';

  @override
  String get goal_period => 'Goal Period';

  @override
  String get unit => 'Unit';

  @override
  String get goal_amount => 'Target Amount';

  @override
  String get uric_acid => 'Uric Acid';

  @override
  String get date_example => 'e.g. 2000.01.01';

  @override
  String get recent_data => 'Recent Data';

  @override
  String get latest => 'Newest';

  @override
  String get oldest => 'Oldest';

  @override
  String get add_data => 'Add Data';

  @override
  String get date => 'Date';

  @override
  String get datetime_example => 'e.g. 2000.01.01 13:30';

  @override
  String get value => 'Value';

  @override
  String get initial => 'Initial';

  @override
  String get current => 'Current';

  @override
  String get target => 'Target';

  @override
  String get goal_already_done => 'This goal is already achieved!';

  @override
  String get enter_value => 'Please enter a value.';

  @override
  String get set_as_representative => 'Set as primary?';

  @override
  String get goal_already_achieved =>
      'You can’t add data to a goal that’s already achieved.';

  @override
  String get menu => 'Menu';

  @override
  String get language_setting => 'Language';

  @override
  String get date_setting => 'Date Notation';

  @override
  String get notification_setting => 'Notifications';

  @override
  String get logout => 'Log Out';

  @override
  String get withdraw_account => 'Delete Account';

  @override
  String get withdraw_error => 'An error occurred while deleting your account.';

  @override
  String get auto_language => 'Auto Language';

  @override
  String get auto_date => 'Auto Date Notation';

  @override
  String get no_notifications => 'No notifications set';

  @override
  String get add_notification => 'Add Notification';

  @override
  String get notification_name => 'Notification Name';

  @override
  String get breakfast_alarm => 'Breakfast';

  @override
  String get enter_notification_name => 'Please enter a notification name.';

  @override
  String get need_noti_perm => 'Enable notifications';

  @override
  String get request_noti_perm =>
      'to get meal reminders\nat your preferred time';

  @override
  String get open_setting => 'Open Setting';

  @override
  String get meal_tutorial_step_one =>
      'Swipe down to view your monthly summary.';

  @override
  String get meal_tutorial_step_two => 'Tap to log today’s meals.';

  @override
  String get meal_tutorial_step_three =>
      'Log your meals and discover insights with AI.';

  @override
  String get meal_feedback => 'Meal Feedback';

  @override
  String get meal_analysis => 'Nutrition Analysis';

  @override
  String get good_thing => 'Good';

  @override
  String get bad_thing => 'Improve';

  @override
  String get next_step => 'Next steps';
}
