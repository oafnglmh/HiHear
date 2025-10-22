import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
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
  /// **'AI-powered personalized language learning'**
  String get splashTagline;

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

  /// No description provided for @translWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to HiHear'**
  String get translWelcome;

  /// No description provided for @dailyGoalQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your daily goal?'**
  String get dailyGoalQuestion;

  /// No description provided for @minuteLabel.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minuteLabel;

  /// No description provided for @dayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day'**
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
  /// **'Let\'s start your learning journey!'**
  String get journeyStartMessage;

  /// No description provided for @seriesOfDays.
  ///
  /// In en, this message translates to:
  /// **'Series of days'**
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
  /// **'Application'**
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
  /// **'Others'**
  String get settingOtherSection;

  /// No description provided for @settingHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingHelpSupport;

  /// No description provided for @settingAboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Application'**
  String get settingAboutApp;

  /// No description provided for @languageSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageSelectTitle;

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

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpTitle;

  /// No description provided for @helpUsageGuide.
  ///
  /// In en, this message translates to:
  /// **'User Guide'**
  String get helpUsageGuide;

  /// No description provided for @helpStartLearning.
  ///
  /// In en, this message translates to:
  /// **'Getting Started with HiHear'**
  String get helpStartLearning;

  /// No description provided for @helpStartLearningDesc.
  ///
  /// In en, this message translates to:
  /// **'Select the \'Study\' section on the home page to start lessons suitable for your level. The app will automatically analyze your voice and provide feedback to improve your skills.'**
  String get helpStartLearningDesc;

  /// No description provided for @helpVocabManage.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary Management'**
  String get helpVocabManage;

  /// No description provided for @helpVocabManageDesc.
  ///
  /// In en, this message translates to:
  /// **'When you encounter a new word, you can save it in the \'Vocabulary\' section for review later. Here you can listen to pronunciation, see meanings, and real examples.'**
  String get helpVocabManageDesc;

  /// No description provided for @helpSpeakAI.
  ///
  /// In en, this message translates to:
  /// **'Speaking Practice & AI Feedback'**
  String get helpSpeakAI;

  /// No description provided for @helpSpeakAIDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap the microphone icon to record your voice. AI will analyze your pronunciation and score it immediately.'**
  String get helpSpeakAIDesc;

  /// No description provided for @helpFAQ.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions (FAQ)'**
  String get helpFAQ;

  /// No description provided for @helpFAQInternetQ.
  ///
  /// In en, this message translates to:
  /// **'Do I need an Internet connection to use HiHear?'**
  String get helpFAQInternetQ;

  /// No description provided for @helpFAQInternetA.
  ///
  /// In en, this message translates to:
  /// **'Yes. HiHear uses AI models on the server, so an internet connection is required to process audio and sync learning data.'**
  String get helpFAQInternetA;

  /// No description provided for @helpFAQProgressQ.
  ///
  /// In en, this message translates to:
  /// **'Does the app save my learning progress?'**
  String get helpFAQProgressQ;

  /// No description provided for @helpFAQProgressA.
  ///
  /// In en, this message translates to:
  /// **'Yes. Learning progress, vocabulary, and listening results are automatically saved to your cloud account.'**
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
  /// **'We’re always ready to assist you 24/7'**
  String get helpSupportNote;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get aboutTitle;

  /// No description provided for @aboutAppName.
  ///
  /// In en, this message translates to:
  /// **'HiHear'**
  String get aboutAppName;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutVersion;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'HiHear is an intelligent English listening, vocabulary, and grammar learning app. It combines artificial intelligence to help users enhance listening comprehension through interactive lessons and voice analysis.'**
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
  /// **'Support Email'**
  String get aboutEmail;

  /// No description provided for @aboutEmailValue.
  ///
  /// In en, this message translates to:
  /// **'hcassano.dev@gmail.com'**
  String get aboutEmailValue;

  /// No description provided for @aboutWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get aboutWebsite;

  /// No description provided for @aboutWebsiteValue.
  ///
  /// In en, this message translates to:
  /// **'hihear.com'**
  String get aboutWebsiteValue;

  /// No description provided for @aboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 HiHear. All rights reserved.'**
  String get aboutCopyright;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
