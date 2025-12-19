import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
    Locale('vi')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'HiHear'**
  String get appName;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Personalized AI-powered language learning'**
  String get splashTagline;

  /// No description provided for @dailyGoalQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your daily goal?'**
  String get dailyGoalQuestion;

  /// No description provided for @minuteLabel.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minuteLabel;

  /// No description provided for @dayLabel.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get dayLabel;

  /// No description provided for @difficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// No description provided for @difficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get difficultyMedium;

  /// No description provided for @difficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get difficultyHard;

  /// No description provided for @difficultyVeryHard.
  ///
  /// In en, this message translates to:
  /// **'Very Hard'**
  String get difficultyVeryHard;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startButton;

  /// No description provided for @journeyStartMessage.
  ///
  /// In en, this message translates to:
  /// **'Let\'s begin your learning journey!'**
  String get journeyStartMessage;

  /// No description provided for @seriesOfDays.
  ///
  /// In en, this message translates to:
  /// **'Day Streak'**
  String get seriesOfDays;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @settingAccountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingAccountSection;

  /// No description provided for @settingPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get settingPersonalInfo;

  /// No description provided for @settingLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingLogout;

  /// No description provided for @settingAppSection.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get settingAppSection;

  /// No description provided for @settingLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingLanguage;

  /// No description provided for @settingNotification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingNotification;

  /// No description provided for @settingOtherSection.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get settingOtherSection;

  /// No description provided for @settingHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingHelpSupport;

  /// No description provided for @settingAboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get settingAboutApp;

  /// No description provided for @countrySelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your country'**
  String get countrySelectionTitle;

  /// No description provided for @countrySelectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'🇻🇳 Where are you from?'**
  String get countrySelectionSubtitle;

  /// No description provided for @loadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingText;

  /// No description provided for @noCountryFound.
  ///
  /// In en, this message translates to:
  /// **'No country found'**
  String get noCountryFound;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @levelCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Level Test'**
  String get levelCheckTitle;

  /// No description provided for @levelCheckSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose test language 🪷'**
  String get levelCheckSubtitle;

  /// No description provided for @levelCheckQuestion.
  ///
  /// In en, this message translates to:
  /// **'Please select the language to start your Vietnamese proficiency test!'**
  String get levelCheckQuestion;

  /// No description provided for @englishTestTitle.
  ///
  /// In en, this message translates to:
  /// **'English Test'**
  String get englishTestTitle;

  /// No description provided for @englishTestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take the test in English'**
  String get englishTestSubtitle;

  /// No description provided for @koreanTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Korean Test'**
  String get koreanTestTitle;

  /// No description provided for @koreanTestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'한국어로 시험보기'**
  String get koreanTestSubtitle;

  /// No description provided for @vietnameseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnameseLanguage;

  /// No description provided for @testSelectAnswerWarning.
  ///
  /// In en, this message translates to:
  /// **'Please select an answer!'**
  String get testSelectAnswerWarning;

  /// No description provided for @testCongratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get testCongratulations;

  /// No description provided for @testPassedLevel.
  ///
  /// In en, this message translates to:
  /// **'You have passed'**
  String get testPassedLevel;

  /// No description provided for @testScore.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get testScore;

  /// No description provided for @testReadyNextChallenge.
  ///
  /// In en, this message translates to:
  /// **'Ready for the next challenge?'**
  String get testReadyNextChallenge;

  /// No description provided for @testContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get testContinue;

  /// No description provided for @testExcellent.
  ///
  /// In en, this message translates to:
  /// **'🌟 Excellent!'**
  String get testExcellent;

  /// No description provided for @testKeepTrying.
  ///
  /// In en, this message translates to:
  /// **'💪 Keep trying!'**
  String get testKeepTrying;

  /// No description provided for @testYourLevel.
  ///
  /// In en, this message translates to:
  /// **'Your level:'**
  String get testYourLevel;

  /// No description provided for @testNotReached.
  ///
  /// In en, this message translates to:
  /// **'Not reached'**
  String get testNotReached;

  /// No description provided for @testReached.
  ///
  /// In en, this message translates to:
  /// **'Reached'**
  String get testReached;

  /// No description provided for @testLevelScore.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get testLevelScore;

  /// No description provided for @testCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed:'**
  String get testCompleted;

  /// No description provided for @testFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get testFinish;

  /// No description provided for @testLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading test...'**
  String get testLoading;

  /// No description provided for @testQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get testQuestion;

  /// No description provided for @testNextQuestion.
  ///
  /// In en, this message translates to:
  /// **'Next question'**
  String get testNextQuestion;

  /// No description provided for @aiChatReadyToChat.
  ///
  /// In en, this message translates to:
  /// **'Ready to chat'**
  String get aiChatReadyToChat;

  /// No description provided for @aiChatListening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get aiChatListening;

  /// No description provided for @aiChatThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get aiChatThinking;

  /// No description provided for @aiChatSpeaking.
  ///
  /// In en, this message translates to:
  /// **'Speaking...'**
  String get aiChatSpeaking;

  /// No description provided for @aiChatListeningNow.
  ///
  /// In en, this message translates to:
  /// **'Listening now...'**
  String get aiChatListeningNow;

  /// No description provided for @aiChatRecognized.
  ///
  /// In en, this message translates to:
  /// **'Recognized'**
  String get aiChatRecognized;

  /// No description provided for @aiChatSaySomething.
  ///
  /// In en, this message translates to:
  /// **'Say something...'**
  String get aiChatSaySomething;

  /// No description provided for @aiChatErrorSpeechRecognition.
  ///
  /// In en, this message translates to:
  /// **'Speech recognition error'**
  String get aiChatErrorSpeechRecognition;

  /// No description provided for @aiChatErrorSpeechNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to start speech recognition'**
  String get aiChatErrorSpeechNotAvailable;

  /// No description provided for @homeTabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTabHome;

  /// No description provided for @homeTabSpeak.
  ///
  /// In en, this message translates to:
  /// **'Practice Speaking'**
  String get homeTabSpeak;

  /// No description provided for @homeTabAi.
  ///
  /// In en, this message translates to:
  /// **'Hearu AI'**
  String get homeTabAi;

  /// No description provided for @homeTabSavedVocab.
  ///
  /// In en, this message translates to:
  /// **'Saved Vocabulary'**
  String get homeTabSavedVocab;

  /// No description provided for @homeTabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get homeTabProfile;

  /// No description provided for @streakPopupTitle.
  ///
  /// In en, this message translates to:
  /// **'{streakDays}-day streak!'**
  String streakPopupTitle(Object streakDays);

  /// No description provided for @streakPopupMessage.
  ///
  /// In en, this message translates to:
  /// **'Amazing! Keep it up!'**
  String get streakPopupMessage;

  /// No description provided for @streakPopupButton.
  ///
  /// In en, this message translates to:
  /// **'Continue Learning'**
  String get streakPopupButton;

  /// No description provided for @lessonPathLevelHeader.
  ///
  /// In en, this message translates to:
  /// **'SECTION 1, UNIT 1'**
  String get lessonPathLevelHeader;

  /// No description provided for @lessonPathLockedDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson Locked'**
  String get lessonPathLockedDialogTitle;

  /// No description provided for @lessonPathLockedDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You need to complete previous lessons to unlock this one.'**
  String get lessonPathLockedDialogContent;

  /// No description provided for @lessonPathLockedDialogButton.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get lessonPathLockedDialogButton;

  /// No description provided for @homeHeaderGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get homeHeaderGreeting;

  /// No description provided for @homeHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s learn Vietnamese!'**
  String get homeHeaderSubtitle;

  /// No description provided for @grammarLessonAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Grammar'**
  String get grammarLessonAppBarTitle;

  /// No description provided for @grammarLessonProgressSentence.
  ///
  /// In en, this message translates to:
  /// **'Sentence {current}/{total}'**
  String grammarLessonProgressSentence(Object current, Object total);

  /// No description provided for @grammarLessonProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String grammarLessonProgressPercent(Object percent);

  /// No description provided for @grammarLessonLevelEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get grammarLessonLevelEasy;

  /// No description provided for @grammarLessonCategoryGrammar.
  ///
  /// In en, this message translates to:
  /// **'Grammar'**
  String get grammarLessonCategoryGrammar;

  /// No description provided for @grammarLessonDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get grammarLessonDefaultTitle;

  /// No description provided for @grammarLessonGrammarRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Grammar Rule'**
  String get grammarLessonGrammarRuleTitle;

  /// No description provided for @grammarLessonExampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get grammarLessonExampleTitle;

  /// No description provided for @grammarLessonTranslationTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get grammarLessonTranslationTitle;

  /// No description provided for @grammarLessonPreviousButton.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get grammarLessonPreviousButton;

  /// No description provided for @grammarLessonNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get grammarLessonNextButton;

  /// No description provided for @grammarLessonCompleteButton.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get grammarLessonCompleteButton;

  /// No description provided for @grammarLessonEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No grammar content'**
  String get grammarLessonEmptyTitle;

  /// No description provided for @grammarLessonErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get grammarLessonErrorTitle;

  /// No description provided for @grammarLessonErrorRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get grammarLessonErrorRetryButton;

  /// No description provided for @grammarLessonCompletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get grammarLessonCompletionTitle;

  /// No description provided for @grammarLessonCompletionMessage.
  ///
  /// In en, this message translates to:
  /// **'You have completed this grammar lesson.'**
  String get grammarLessonCompletionMessage;

  /// No description provided for @grammarLessonCompletionHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get grammarLessonCompletionHomeButton;

  /// No description provided for @vocabLessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Vocabulary'**
  String get vocabLessonTitle;

  /// No description provided for @vocabLessonProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current}/{total}'**
  String vocabLessonProgress(Object current, Object total);

  /// No description provided for @vocabLessonEmpty.
  ///
  /// In en, this message translates to:
  /// **'No questions'**
  String get vocabLessonEmpty;

  /// No description provided for @vocabLessonError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String vocabLessonError(Object message);

  /// No description provided for @vocabLessonFeedbackCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get vocabLessonFeedbackCorrect;

  /// No description provided for @vocabLessonFeedbackWrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong!'**
  String get vocabLessonFeedbackWrong;

  /// No description provided for @vocabLessonExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get vocabLessonExplanationTitle;

  /// No description provided for @vocabLessonSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Word'**
  String get vocabLessonSaveButton;

  /// No description provided for @vocabLessonNextButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get vocabLessonNextButton;

  /// No description provided for @vocabLessonResultPassedTitle.
  ///
  /// In en, this message translates to:
  /// **'Excellent! '**
  String get vocabLessonResultPassedTitle;

  /// No description provided for @vocabLessonResultFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep Trying! '**
  String get vocabLessonResultFailedTitle;

  /// No description provided for @vocabLessonResultPassedMessage.
  ///
  /// In en, this message translates to:
  /// **'You have passed the test!'**
  String get vocabLessonResultPassedMessage;

  /// No description provided for @vocabLessonResultFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Try again for a better result'**
  String get vocabLessonResultFailedMessage;

  /// No description provided for @vocabLessonResultScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'score'**
  String get vocabLessonResultScoreLabel;

  /// No description provided for @vocabLessonResultCorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get vocabLessonResultCorrectLabel;

  /// No description provided for @vocabLessonResultWrongLabel.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get vocabLessonResultWrongLabel;

  /// No description provided for @vocabLessonResultTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get vocabLessonResultTotalLabel;

  /// No description provided for @vocabLessonResultCompleteButton.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get vocabLessonResultCompleteButton;

  /// No description provided for @guestButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get guestButtonLabel;

  /// No description provided for @loadingIndicatorText.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loadingIndicatorText;

  /// No description provided for @translLoginGg.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get translLoginGg;

  /// No description provided for @translLoginFb.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get translLoginFb;

  /// No description provided for @loginDividerOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get loginDividerOr;

  /// No description provided for @translWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get translWelcome;

  /// No description provided for @translSlogan.
  ///
  /// In en, this message translates to:
  /// **'Learn Vietnamese Together'**
  String get translSlogan;

  /// No description provided for @profileDefaultName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get profileDefaultName;

  /// No description provided for @profileNoEmail.
  ///
  /// In en, this message translates to:
  /// **'No email'**
  String get profileNoEmail;

  /// No description provided for @profileLogoutTooltip.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogoutTooltip;

  /// No description provided for @profileStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'Day Streak'**
  String get profileStreakTitle;

  /// No description provided for @profileLessonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get profileLessonsTitle;

  /// No description provided for @profilePointsTitle.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get profilePointsTitle;

  /// No description provided for @profileSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'Settings & Options'**
  String get profileSettingsSection;

  /// No description provided for @profileEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditProfile;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get profilePrivacy;

  /// No description provided for @profileHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get profileHelp;

  /// No description provided for @profileAbout.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get profileAbout;

  /// No description provided for @savedVocabTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Vocabulary'**
  String get savedVocabTitle;

  /// No description provided for @savedVocabCount.
  ///
  /// In en, this message translates to:
  /// **'{count} words'**
  String savedVocabCount(Object count);

  /// No description provided for @savedVocabSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search vocabulary...'**
  String get savedVocabSearchHint;

  /// No description provided for @savedVocabDisplayedLabel.
  ///
  /// In en, this message translates to:
  /// **'Displayed'**
  String get savedVocabDisplayedLabel;

  /// No description provided for @savedVocabTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total words'**
  String get savedVocabTotalLabel;

  /// No description provided for @savedVocabEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No vocabulary yet'**
  String get savedVocabEmptyTitle;

  /// No description provided for @savedVocabEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start saving your vocabulary'**
  String get savedVocabEmptySubtitle;

  /// No description provided for @savedVocabNoResultTitle.
  ///
  /// In en, this message translates to:
  /// **'No words found'**
  String get savedVocabNoResultTitle;

  /// No description provided for @savedVocabNoResultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords'**
  String get savedVocabNoResultSubtitle;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutTitle;

  /// No description provided for @aboutAppName.
  ///
  /// In en, this message translates to:
  /// **'HiHear Mo'**
  String get aboutAppName;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutVersion;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'HiHear Mo is a Vietnamese learning app designed for foreigners, helping you easily access the Vietnamese language and culture through engaging grammar, vocabulary, and pronunciation lessons.'**
  String get aboutDescription;

  /// No description provided for @aboutDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get aboutDeveloper;

  /// No description provided for @aboutDeveloperValue.
  ///
  /// In en, this message translates to:
  /// **'HiHear Team'**
  String get aboutDeveloperValue;

  /// No description provided for @aboutEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact Email'**
  String get aboutEmail;

  /// No description provided for @aboutEmailValue.
  ///
  /// In en, this message translates to:
  /// **'support@hihearmo.com'**
  String get aboutEmailValue;

  /// No description provided for @aboutWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get aboutWebsite;

  /// No description provided for @aboutWebsiteValue.
  ///
  /// In en, this message translates to:
  /// **'www.hihearmo.com'**
  String get aboutWebsiteValue;

  /// No description provided for @aboutFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get aboutFeaturesTitle;

  /// No description provided for @aboutFeatureVocab.
  ///
  /// In en, this message translates to:
  /// **'Learn Vietnamese vocabulary'**
  String get aboutFeatureVocab;

  /// No description provided for @aboutFeaturePronunciation.
  ///
  /// In en, this message translates to:
  /// **'Practice accurate pronunciation'**
  String get aboutFeaturePronunciation;

  /// No description provided for @aboutFeatureSave.
  ///
  /// In en, this message translates to:
  /// **'Save favorite words'**
  String get aboutFeatureSave;

  /// No description provided for @aboutFeatureProgress.
  ///
  /// In en, this message translates to:
  /// **'Track your progress'**
  String get aboutFeatureProgress;

  /// No description provided for @aboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 HiHear Mo. All rights reserved.\nMade with ❤️ in Vietnam'**
  String get aboutCopyright;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpTitle;

  /// No description provided for @helpUsageGuide.
  ///
  /// In en, this message translates to:
  /// **'Usage Guide'**
  String get helpUsageGuide;

  /// No description provided for @helpStartLearning.
  ///
  /// In en, this message translates to:
  /// **'Start Learning'**
  String get helpStartLearning;

  /// No description provided for @helpStartLearningDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose vocabulary or grammar lessons from the Home tab, complete each lesson to unlock the next one.'**
  String get helpStartLearningDesc;

  /// No description provided for @helpVocabManage.
  ///
  /// In en, this message translates to:
  /// **'Manage Vocabulary'**
  String get helpVocabManage;

  /// No description provided for @helpVocabManageDesc.
  ///
  /// In en, this message translates to:
  /// **'In vocabulary lessons, you can save favorite words using the \'Save Word\' button in the feedback after each question.'**
  String get helpVocabManageDesc;

  /// No description provided for @helpSpeakAI.
  ///
  /// In en, this message translates to:
  /// **'Chat with Hearu AI'**
  String get helpSpeakAI;

  /// No description provided for @helpSpeakAIDesc.
  ///
  /// In en, this message translates to:
  /// **'Go to the Hearu AI tab to practice free conversation. Press and hold the mic button to speak, release for AI to respond with voice.'**
  String get helpSpeakAIDesc;

  /// No description provided for @helpFAQ.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get helpFAQ;

  /// No description provided for @helpFAQInternetQ.
  ///
  /// In en, this message translates to:
  /// **'Does the app require an Internet connection?'**
  String get helpFAQInternetQ;

  /// No description provided for @helpFAQInternetA.
  ///
  /// In en, this message translates to:
  /// **'Yes, the app requires an Internet connection to load lessons and use the AI chat feature.'**
  String get helpFAQInternetA;

  /// No description provided for @helpFAQProgressQ.
  ///
  /// In en, this message translates to:
  /// **'How is learning progress saved?'**
  String get helpFAQProgressQ;

  /// No description provided for @helpFAQProgressA.
  ///
  /// In en, this message translates to:
  /// **'Your progress is automatically saved to your account. You can view your streak and stats in your Profile.'**
  String get helpFAQProgressA;

  /// No description provided for @helpContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get helpContact;

  /// No description provided for @helpContactEmail.
  ///
  /// In en, this message translates to:
  /// **'Support Email'**
  String get helpContactEmail;

  /// No description provided for @helpContactWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get helpContactWebsite;

  /// No description provided for @helpContactHotline.
  ///
  /// In en, this message translates to:
  /// **'Hotline'**
  String get helpContactHotline;

  /// No description provided for @helpSupportNote.
  ///
  /// In en, this message translates to:
  /// **'We are always here to help!\nIf you encounter any issues or have suggestions, feel free to contact us through the channels above.'**
  String get helpSupportNote;

  /// No description provided for @languageSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSelectTitle;

  /// No description provided for @languageSelectHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get languageSelectHeaderTitle;

  /// No description provided for @languageSelectHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your language'**
  String get languageSelectHeaderSubtitle;

  /// No description provided for @languageSelectNote.
  ///
  /// In en, this message translates to:
  /// **'Language changes will be applied immediately'**
  String get languageSelectNote;

  /// No description provided for @languageVietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get languageVietnamese;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @speakPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation'**
  String get speakPageTitle;

  /// No description provided for @speakPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn accurate pronunciation'**
  String get speakPageSubtitle;

  /// No description provided for @speakPageIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s learn Vietnamese pronunciation together!'**
  String get speakPageIntroTitle;

  /// No description provided for @speakPageIntroDesc.
  ///
  /// In en, this message translates to:
  /// **'Listen and practice pronouncing Vietnamese sounds'**
  String get speakPageIntroDesc;

  /// No description provided for @speakPageStartButton.
  ///
  /// In en, this message translates to:
  /// **'START LESSON'**
  String get speakPageStartButton;

  /// No description provided for @speakSectionTones.
  ///
  /// In en, this message translates to:
  /// **'Tones'**
  String get speakSectionTones;

  /// No description provided for @speakSectionVowels.
  ///
  /// In en, this message translates to:
  /// **'Vowels'**
  String get speakSectionVowels;

  /// No description provided for @speakSectionConsonants.
  ///
  /// In en, this message translates to:
  /// **'Consonants'**
  String get speakSectionConsonants;

  /// No description provided for @speakSectionDiphthongs.
  ///
  /// In en, this message translates to:
  /// **'Diphthongs'**
  String get speakSectionDiphthongs;

  /// No description provided for @speakSectionCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sounds'**
  String speakSectionCount(Object count);

  /// No description provided for @speakingLessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation Practice'**
  String get speakingLessonTitle;

  /// No description provided for @speakingLessonProgress.
  ///
  /// In en, this message translates to:
  /// **'Sentence {current}/{total}'**
  String speakingLessonProgress(Object current, Object total);

  /// No description provided for @speakingLessonProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String speakingLessonProgressPercent(Object percent);

  /// No description provided for @speakingLessonLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language: {lang}'**
  String speakingLessonLanguage(Object lang);

  /// No description provided for @speakingLessonReadPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please read the following sentence:'**
  String get speakingLessonReadPrompt;

  /// No description provided for @speakingLessonYouSaid.
  ///
  /// In en, this message translates to:
  /// **'You said:'**
  String get speakingLessonYouSaid;

  /// No description provided for @speakingLessonErrorNoSpeech.
  ///
  /// In en, this message translates to:
  /// **'No speech detected. Please try again!'**
  String get speakingLessonErrorNoSpeech;

  /// No description provided for @speakingLessonErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get speakingLessonErrorTitle;

  /// No description provided for @speakingLessonErrorRetry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get speakingLessonErrorRetry;

  /// No description provided for @speakingLessonInitial.
  ///
  /// In en, this message translates to:
  /// **'Initializing...'**
  String get speakingLessonInitial;

  /// No description provided for @speakingLessonNoLesson.
  ///
  /// In en, this message translates to:
  /// **'No lessons available'**
  String get speakingLessonNoLesson;

  /// No description provided for @speakingLessonNoContent.
  ///
  /// In en, this message translates to:
  /// **'Lesson has no content'**
  String get speakingLessonNoContent;

  /// No description provided for @speakingLessonNoSentence.
  ///
  /// In en, this message translates to:
  /// **'No sentences to read'**
  String get speakingLessonNoSentence;

  /// No description provided for @speakingLessonFeedbackExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent!'**
  String get speakingLessonFeedbackExcellent;

  /// No description provided for @speakingLessonFeedbackImprove.
  ///
  /// In en, this message translates to:
  /// **'Needs improvement'**
  String get speakingLessonFeedbackImprove;

  /// No description provided for @speakingLessonFeedbackMistakes.
  ///
  /// In en, this message translates to:
  /// **'Words to note:'**
  String get speakingLessonFeedbackMistakes;

  /// No description provided for @speakingLessonFeedbackRetry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get speakingLessonFeedbackRetry;

  /// No description provided for @speakingLessonFeedbackContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get speakingLessonFeedbackContinue;

  /// No description provided for @speakingLessonCompletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed!'**
  String get speakingLessonCompletionTitle;

  /// No description provided for @speakingLessonCompletionMessage.
  ///
  /// In en, this message translates to:
  /// **'You have completed all speaking lessons!'**
  String get speakingLessonCompletionMessage;

  /// No description provided for @speakingLessonCompletionHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get speakingLessonCompletionHome;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ko', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ko': return AppLocalizationsKo();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
