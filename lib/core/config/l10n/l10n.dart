import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get start;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get complete;

  /// No description provided for @edit_complete.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get edit_complete;

  /// No description provided for @confirm_delete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get confirm_delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out?'**
  String get confirm_logout;

  /// No description provided for @confirm_withdraw.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete your account?'**
  String get confirm_withdraw;

  /// No description provided for @withdraw_warning.
  ///
  /// In en, this message translates to:
  /// **'All data will be permanently deleted and cannot be restored.'**
  String get withdraw_warning;

  /// No description provided for @keep_account.
  ///
  /// In en, this message translates to:
  /// **'Keep Account'**
  String get keep_account;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get withdraw;

  /// No description provided for @apple_login.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get apple_login;

  /// No description provided for @kakao_login.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Kakao'**
  String get kakao_login;

  /// No description provided for @gogole_login.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get gogole_login;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms;

  /// No description provided for @policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get policy;

  /// No description provided for @agree_terms_privacy.
  ///
  /// In en, this message translates to:
  /// **'I agree to the {terms} and {privacy}.'**
  String agree_terms_privacy(Object terms, Object privacy);

  /// No description provided for @intro_1_title.
  ///
  /// In en, this message translates to:
  /// **'Easily record\nyour meals every day'**
  String get intro_1_title;

  /// No description provided for @intro_1_highlight.
  ///
  /// In en, this message translates to:
  /// **'record'**
  String get intro_1_highlight;

  /// No description provided for @intro_2_title.
  ///
  /// In en, this message translates to:
  /// **'See your health info\nat a glance with meal reminders'**
  String get intro_2_title;

  /// No description provided for @intro_2_highlight.
  ///
  /// In en, this message translates to:
  /// **'health info'**
  String get intro_2_highlight;

  /// No description provided for @intro_3_title.
  ///
  /// In en, this message translates to:
  /// **'Share your healthy recipes\nwith others'**
  String get intro_3_title;

  /// No description provided for @intro_3_highlight.
  ///
  /// In en, this message translates to:
  /// **'healthy recipes'**
  String get intro_3_highlight;

  /// No description provided for @intro_4_title.
  ///
  /// In en, this message translates to:
  /// **'Manage meals more easily\nwith widgets'**
  String get intro_4_title;

  /// No description provided for @intro_4_highlight.
  ///
  /// In en, this message translates to:
  /// **'widgets'**
  String get intro_4_highlight;

  /// No description provided for @profileTitleAppName.
  ///
  /// In en, this message translates to:
  /// **'VitaMeal'**
  String get profileTitleAppName;

  /// No description provided for @profileTitleSuffix.
  ///
  /// In en, this message translates to:
  /// **' profile\n'**
  String get profileTitleSuffix;

  /// No description provided for @profileTitleProfile.
  ///
  /// In en, this message translates to:
  /// **''**
  String get profileTitleProfile;

  /// No description provided for @profileTitleObject.
  ///
  /// In en, this message translates to:
  /// **''**
  String get profileTitleObject;

  /// No description provided for @profileTitleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileTitleEdit;

  /// No description provided for @profileTitleSet.
  ///
  /// In en, this message translates to:
  /// **'Set up'**
  String get profileTitleSet;

  /// No description provided for @profileTitleEnd.
  ///
  /// In en, this message translates to:
  /// **' your profile.'**
  String get profileTitleEnd;

  /// No description provided for @welcomePrefix.
  ///
  /// In en, this message translates to:
  /// **'Welcome, '**
  String get welcomePrefix;

  /// No description provided for @member.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get member;

  /// No description provided for @editInfoSuffix.
  ///
  /// In en, this message translates to:
  /// **'\nEdit your basic information. (Optional)'**
  String get editInfoSuffix;

  /// No description provided for @inputInfoSuffix.
  ///
  /// In en, this message translates to:
  /// **'!\nEnter your basic information. (Optional)'**
  String get inputInfoSuffix;

  /// No description provided for @diseaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Health conditions to manage'**
  String get diseaseTitle;

  /// No description provided for @allSelectOptional.
  ///
  /// In en, this message translates to:
  /// **'Select all that apply. (Optional)'**
  String get allSelectOptional;

  /// No description provided for @editOptional.
  ///
  /// In en, this message translates to:
  /// **'Edit your selection. (Optional)'**
  String get editOptional;

  /// No description provided for @allergyPrefix.
  ///
  /// In en, this message translates to:
  /// **'Current '**
  String get allergyPrefix;

  /// No description provided for @allergy.
  ///
  /// In en, this message translates to:
  /// **'allergies'**
  String get allergy;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @nickname_example.
  ///
  /// In en, this message translates to:
  /// **'Vitameal'**
  String get nickname_example;

  /// No description provided for @nickname_max_length.
  ///
  /// In en, this message translates to:
  /// **'Nickname must be 10 characters or less.'**
  String get nickname_max_length;

  /// No description provided for @enter_nickname.
  ///
  /// In en, this message translates to:
  /// **'Please enter a nickname.'**
  String get enter_nickname;

  /// No description provided for @duplicate_nickname.
  ///
  /// In en, this message translates to:
  /// **'This nickname is already taken.'**
  String get duplicate_nickname;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @birth_year.
  ///
  /// In en, this message translates to:
  /// **'Birth Year'**
  String get birth_year;

  /// No description provided for @birth_year_invalid.
  ///
  /// In en, this message translates to:
  /// **'Birth year must be a 4-digit number.'**
  String get birth_year_invalid;

  /// No description provided for @birth_year_wrong.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid birth year.'**
  String get birth_year_wrong;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @invalid_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid number.'**
  String get invalid_number;

  /// No description provided for @failed_loading_disease.
  ///
  /// In en, this message translates to:
  /// **'Failed to load the disease list.'**
  String get failed_loading_disease;

  /// No description provided for @failed_loading_allergy.
  ///
  /// In en, this message translates to:
  /// **'Failed to load the allergy list.'**
  String get failed_loading_allergy;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @signup_complete.
  ///
  /// In en, this message translates to:
  /// **'Your signup is complete.'**
  String get signup_complete;

  /// No description provided for @my_diet.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get my_diet;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @no_meal_record.
  ///
  /// In en, this message translates to:
  /// **'No meal records yet'**
  String get no_meal_record;

  /// No description provided for @record_today_meal.
  ///
  /// In en, this message translates to:
  /// **'Record today’s meal'**
  String get record_today_meal;

  /// No description provided for @meal_date.
  ///
  /// In en, this message translates to:
  /// **'Meals on {day}'**
  String meal_date(Object day);

  /// No description provided for @add_image.
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get add_image;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get snack;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get select_time;

  /// No description provided for @no_content.
  ///
  /// In en, this message translates to:
  /// **'No content'**
  String get no_content;

  /// No description provided for @failed_to_load_data.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data.'**
  String get failed_to_load_data;

  /// No description provided for @failed_to_select_image.
  ///
  /// In en, this message translates to:
  /// **'Failed to select image.'**
  String get failed_to_select_image;

  /// No description provided for @login_required.
  ///
  /// In en, this message translates to:
  /// **'Please log in to continue.'**
  String get login_required;

  /// No description provided for @enter_image_or_content.
  ///
  /// In en, this message translates to:
  /// **'Please add an image or meal details.'**
  String get enter_image_or_content;

  /// No description provided for @confirm_delete_meal.
  ///
  /// In en, this message translates to:
  /// **'Delete this meal record?'**
  String get confirm_delete_meal;

  /// No description provided for @failed_to_delete.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete.'**
  String get failed_to_delete;

  /// No description provided for @rate_today_meal.
  ///
  /// In en, this message translates to:
  /// **'How was today’s meal?'**
  String get rate_today_meal;

  /// No description provided for @fine.
  ///
  /// In en, this message translates to:
  /// **'Fine'**
  String get fine;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get great;

  /// No description provided for @analyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// No description provided for @analyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing...'**
  String get analyzing;

  /// No description provided for @reanalyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze Again'**
  String get reanalyze;

  /// No description provided for @analysis_limit.
  ///
  /// In en, this message translates to:
  /// **'Analysis is limited to 3 times per day and resets at midnight.'**
  String get analysis_limit;

  /// No description provided for @ai_result.
  ///
  /// In en, this message translates to:
  /// **'AI Analysis Result'**
  String get ai_result;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @ai_disclaimer.
  ///
  /// In en, this message translates to:
  /// **'This analysis provides general health information and does not replace medical advice.'**
  String get ai_disclaimer;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback by\nmedical condition'**
  String get feedback;

  /// No description provided for @key_points.
  ///
  /// In en, this message translates to:
  /// **'Key Points'**
  String get key_points;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @source_info.
  ///
  /// In en, this message translates to:
  /// **'Sources & Health Information'**
  String get source_info;

  /// No description provided for @failed_to_analyze.
  ///
  /// In en, this message translates to:
  /// **'Analysis failed'**
  String get failed_to_analyze;

  /// No description provided for @check_connection.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection.'**
  String get check_connection;

  /// No description provided for @need_connection.
  ///
  /// In en, this message translates to:
  /// **'Internet Connection Required'**
  String get need_connection;

  /// No description provided for @need_connection_detail.
  ///
  /// In en, this message translates to:
  /// **'An internet connection is required to view detailed analysis results.'**
  String get need_connection_detail;

  /// No description provided for @over_analysis_limit.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached your daily analysis limit.'**
  String get over_analysis_limit;

  /// No description provided for @no_condition_feedback.
  ///
  /// In en, this message translates to:
  /// **'No condition feedback.'**
  String get no_condition_feedback;

  /// No description provided for @recipe_feed.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get recipe_feed;

  /// No description provided for @search_recipe_hint.
  ///
  /// In en, this message translates to:
  /// **'Search for recipes you like!'**
  String get search_recipe_hint;

  /// No description provided for @no_search_result.
  ///
  /// In en, this message translates to:
  /// **'No results found.'**
  String get no_search_result;

  /// No description provided for @saved_recipes.
  ///
  /// In en, this message translates to:
  /// **'Saved Recipes'**
  String get saved_recipes;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @my_recipes.
  ///
  /// In en, this message translates to:
  /// **'My Recipes'**
  String get my_recipes;

  /// No description provided for @empty_list.
  ///
  /// In en, this message translates to:
  /// **'The list is empty.'**
  String get empty_list;

  /// No description provided for @create_recipe.
  ///
  /// In en, this message translates to:
  /// **'Create Recipe'**
  String get create_recipe;

  /// No description provided for @add_cover_image.
  ///
  /// In en, this message translates to:
  /// **'Add Cover Image'**
  String get add_cover_image;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @enter_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter a title'**
  String get enter_title_hint;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @enter_ingredients_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter ingredient details'**
  String get enter_ingredients_hint;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @recipe_steps.
  ///
  /// In en, this message translates to:
  /// **'Recipe Steps'**
  String get recipe_steps;

  /// No description provided for @step_description_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter description for\nStep {step}'**
  String step_description_hint(Object step);

  /// No description provided for @add_recipe_step.
  ///
  /// In en, this message translates to:
  /// **'Add Step'**
  String get add_recipe_step;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete_action.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete_action;

  /// No description provided for @edit_recipe.
  ///
  /// In en, this message translates to:
  /// **'Edit Recipe'**
  String get edit_recipe;

  /// No description provided for @post_deleted.
  ///
  /// In en, this message translates to:
  /// **'The post has been deleted.'**
  String get post_deleted;

  /// No description provided for @enter_title.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title.'**
  String get enter_title;

  /// No description provided for @register_representative_image.
  ///
  /// In en, this message translates to:
  /// **'Please add a cover image.'**
  String get register_representative_image;

  /// No description provided for @register_all_steps.
  ///
  /// In en, this message translates to:
  /// **'Please add images and descriptions for all steps.'**
  String get register_all_steps;

  /// No description provided for @failed_to_load_tags.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tags'**
  String get failed_to_load_tags;

  /// No description provided for @failed_to_load_posts.
  ///
  /// In en, this message translates to:
  /// **'Unable to load posts.'**
  String get failed_to_load_posts;

  /// No description provided for @cannot_bookmark_own_post.
  ///
  /// In en, this message translates to:
  /// **'You can\'t bookmark your own post.'**
  String get cannot_bookmark_own_post;

  /// No description provided for @no_date_info.
  ///
  /// In en, this message translates to:
  /// **'No date available.'**
  String get no_date_info;

  /// No description provided for @anonymous_chef.
  ///
  /// In en, this message translates to:
  /// **'Anonymous Chef'**
  String get anonymous_chef;

  /// No description provided for @my_info.
  ///
  /// In en, this message translates to:
  /// **'My Info'**
  String get my_info;

  /// No description provided for @year_old.
  ///
  /// In en, this message translates to:
  /// **'   '**
  String get year_old;

  /// No description provided for @failed_loading_info.
  ///
  /// In en, this message translates to:
  /// **'Failed to load the info.'**
  String get failed_loading_info;

  /// No description provided for @health_goals.
  ///
  /// In en, this message translates to:
  /// **'Health Goals'**
  String get health_goals;

  /// No description provided for @no_representative_goal.
  ///
  /// In en, this message translates to:
  /// **'No primary goal set'**
  String get no_representative_goal;

  /// No description provided for @recent_graph.
  ///
  /// In en, this message translates to:
  /// **'Recent Graph'**
  String get recent_graph;

  /// No description provided for @add_data_hint.
  ///
  /// In en, this message translates to:
  /// **'Please add data.'**
  String get add_data_hint;

  /// No description provided for @goal_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get goal_title;

  /// No description provided for @goal_value.
  ///
  /// In en, this message translates to:
  /// **'Target Value'**
  String get goal_value;

  /// No description provided for @set_representative.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get set_representative;

  /// No description provided for @no_goals.
  ///
  /// In en, this message translates to:
  /// **'No goals registered'**
  String get no_goals;

  /// No description provided for @add_goal.
  ///
  /// In en, this message translates to:
  /// **'Add Goal'**
  String get add_goal;

  /// No description provided for @edit_goal.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get edit_goal;

  /// No description provided for @new_goal.
  ///
  /// In en, this message translates to:
  /// **'New Goal'**
  String get new_goal;

  /// No description provided for @goal_period.
  ///
  /// In en, this message translates to:
  /// **'Goal Period'**
  String get goal_period;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @goal_amount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get goal_amount;

  /// No description provided for @uric_acid.
  ///
  /// In en, this message translates to:
  /// **'Uric Acid'**
  String get uric_acid;

  /// No description provided for @date_example.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2000.01.01'**
  String get date_example;

  /// No description provided for @recent_data.
  ///
  /// In en, this message translates to:
  /// **'Recent Data'**
  String get recent_data;

  /// No description provided for @latest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get latest;

  /// No description provided for @oldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get oldest;

  /// No description provided for @add_data.
  ///
  /// In en, this message translates to:
  /// **'Add Data'**
  String get add_data;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @datetime_example.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2000.01.01 13:30'**
  String get datetime_example;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @initial.
  ///
  /// In en, this message translates to:
  /// **'Initial'**
  String get initial;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @goal_already_done.
  ///
  /// In en, this message translates to:
  /// **'This goal is already achieved!'**
  String get goal_already_done;

  /// No description provided for @enter_value.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value.'**
  String get enter_value;

  /// No description provided for @set_as_representative.
  ///
  /// In en, this message translates to:
  /// **'Set as primary?'**
  String get set_as_representative;

  /// No description provided for @goal_already_achieved.
  ///
  /// In en, this message translates to:
  /// **'You can’t add data to a goal that’s already achieved.'**
  String get goal_already_achieved;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @language_setting.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_setting;

  /// No description provided for @date_setting.
  ///
  /// In en, this message translates to:
  /// **'Date Notation'**
  String get date_setting;

  /// No description provided for @notification_setting.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification_setting;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @withdraw_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get withdraw_account;

  /// No description provided for @withdraw_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting your account.'**
  String get withdraw_error;

  /// No description provided for @auto_language.
  ///
  /// In en, this message translates to:
  /// **'Auto Language'**
  String get auto_language;

  /// No description provided for @auto_date.
  ///
  /// In en, this message translates to:
  /// **'Auto Date Notation'**
  String get auto_date;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications set'**
  String get no_notifications;

  /// No description provided for @add_notification.
  ///
  /// In en, this message translates to:
  /// **'Add Notification'**
  String get add_notification;

  /// No description provided for @notification_name.
  ///
  /// In en, this message translates to:
  /// **'Notification Name'**
  String get notification_name;

  /// No description provided for @breakfast_alarm.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast_alarm;

  /// No description provided for @enter_notification_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a notification name.'**
  String get enter_notification_name;

  /// No description provided for @meal_tutorial_step_one.
  ///
  /// In en, this message translates to:
  /// **'Swipe down to view your monthly summary.'**
  String get meal_tutorial_step_one;

  /// No description provided for @meal_tutorial_step_two.
  ///
  /// In en, this message translates to:
  /// **'Tap to log today’s meals.'**
  String get meal_tutorial_step_two;

  /// No description provided for @meal_tutorial_step_three.
  ///
  /// In en, this message translates to:
  /// **'Log your meals and discover insights with AI.'**
  String get meal_tutorial_step_three;

  /// No description provided for @meal_feedback.
  ///
  /// In en, this message translates to:
  /// **'Meal Feedback'**
  String get meal_feedback;

  /// No description provided for @meal_analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get meal_analysis;

  /// No description provided for @good_thing.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good_thing;

  /// No description provided for @bad_thing.
  ///
  /// In en, this message translates to:
  /// **'Improve'**
  String get bad_thing;

  /// No description provided for @next_step.
  ///
  /// In en, this message translates to:
  /// **'Next steps'**
  String get next_step;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'ko':
      return L10nKo();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
