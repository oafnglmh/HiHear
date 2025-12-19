// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'HiHear';

  @override
  String get splashTagline => 'Personalized AI-powered language learning';

  @override
  String get dailyGoalQuestion => 'What\'s your daily goal?';

  @override
  String get minuteLabel => 'Minutes';

  @override
  String get dayLabel => 'Days';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get difficultyVeryHard => 'Very Hard';

  @override
  String get nextButton => 'Next';

  @override
  String get startButton => 'Start';

  @override
  String get journeyStartMessage => 'Let\'s begin your learning journey!';

  @override
  String get seriesOfDays => 'Day Streak';

  @override
  String get level => 'Level';

  @override
  String get settingAccountSection => 'Account';

  @override
  String get settingPersonalInfo => 'Personal Information';

  @override
  String get settingLogout => 'Log out';

  @override
  String get settingAppSection => 'App';

  @override
  String get settingLanguage => 'Language';

  @override
  String get settingNotification => 'Notifications';

  @override
  String get settingOtherSection => 'Other';

  @override
  String get settingHelpSupport => 'Help & Support';

  @override
  String get settingAboutApp => 'About App';

  @override
  String get countrySelectionTitle => 'Choose your country';

  @override
  String get countrySelectionSubtitle => '🇻🇳 Where are you from?';

  @override
  String get loadingText => 'Loading...';

  @override
  String get noCountryFound => 'No country found';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get levelCheckTitle => 'Level Test';

  @override
  String get levelCheckSubtitle => 'Choose test language 🪷';

  @override
  String get levelCheckQuestion => 'Please select the language to start your Vietnamese proficiency test!';

  @override
  String get englishTestTitle => 'English Test';

  @override
  String get englishTestSubtitle => 'Take the test in English';

  @override
  String get koreanTestTitle => 'Korean Test';

  @override
  String get koreanTestSubtitle => '한국어로 시험보기';

  @override
  String get vietnameseLanguage => 'Vietnamese';

  @override
  String get testSelectAnswerWarning => 'Please select an answer!';

  @override
  String get testCongratulations => 'Congratulations!';

  @override
  String get testPassedLevel => 'You have passed';

  @override
  String get testScore => 'Score';

  @override
  String get testReadyNextChallenge => 'Ready for the next challenge?';

  @override
  String get testContinue => 'Continue';

  @override
  String get testExcellent => '🌟 Excellent!';

  @override
  String get testKeepTrying => '💪 Keep trying!';

  @override
  String get testYourLevel => 'Your level:';

  @override
  String get testNotReached => 'Not reached';

  @override
  String get testReached => 'Reached';

  @override
  String get testLevelScore => 'Score';

  @override
  String get testCompleted => 'Completed:';

  @override
  String get testFinish => 'Finish';

  @override
  String get testLoading => 'Loading test...';

  @override
  String get testQuestion => 'Question';

  @override
  String get testNextQuestion => 'Next question';

  @override
  String get aiChatReadyToChat => 'Ready to chat';

  @override
  String get aiChatListening => 'Listening...';

  @override
  String get aiChatThinking => 'Thinking...';

  @override
  String get aiChatSpeaking => 'Speaking...';

  @override
  String get aiChatListeningNow => 'Listening now...';

  @override
  String get aiChatRecognized => 'Recognized';

  @override
  String get aiChatSaySomething => 'Say something...';

  @override
  String get aiChatErrorSpeechRecognition => 'Speech recognition error';

  @override
  String get aiChatErrorSpeechNotAvailable => 'Unable to start speech recognition';

  @override
  String get homeTabHome => 'Home';

  @override
  String get homeTabSpeak => 'Practice Speaking';

  @override
  String get homeTabAi => 'Hearu AI';

  @override
  String get homeTabSavedVocab => 'Saved Vocabulary';

  @override
  String get homeTabProfile => 'Profile';

  @override
  String streakPopupTitle(Object streakDays) {
    return '$streakDays-day streak!';
  }

  @override
  String get streakPopupMessage => 'Amazing! Keep it up!';

  @override
  String get streakPopupButton => 'Continue Learning';

  @override
  String get lessonPathLevelHeader => 'SECTION 1, UNIT 1';

  @override
  String get lessonPathLockedDialogTitle => 'Lesson Locked';

  @override
  String get lessonPathLockedDialogContent => 'You need to complete previous lessons to unlock this one.';

  @override
  String get lessonPathLockedDialogButton => 'Got it';

  @override
  String get homeHeaderGreeting => 'Hello!';

  @override
  String get homeHeaderSubtitle => 'Let\'s learn Vietnamese!';

  @override
  String get grammarLessonAppBarTitle => 'Learn Grammar';

  @override
  String grammarLessonProgressSentence(Object current, Object total) {
    return 'Sentence $current/$total';
  }

  @override
  String grammarLessonProgressPercent(Object percent) {
    return '$percent%';
  }

  @override
  String get grammarLessonLevelEasy => 'Easy';

  @override
  String get grammarLessonCategoryGrammar => 'Grammar';

  @override
  String get grammarLessonDefaultTitle => 'Lesson';

  @override
  String get grammarLessonGrammarRuleTitle => 'Grammar Rule';

  @override
  String get grammarLessonExampleTitle => 'Example';

  @override
  String get grammarLessonTranslationTitle => 'Translation';

  @override
  String get grammarLessonPreviousButton => 'Previous';

  @override
  String get grammarLessonNextButton => 'Next';

  @override
  String get grammarLessonCompleteButton => 'Complete';

  @override
  String get grammarLessonEmptyTitle => 'No grammar content';

  @override
  String get grammarLessonErrorTitle => 'An error occurred';

  @override
  String get grammarLessonErrorRetryButton => 'Try Again';

  @override
  String get grammarLessonCompletionTitle => 'Congratulations!';

  @override
  String get grammarLessonCompletionMessage => 'You have completed this grammar lesson.';

  @override
  String get grammarLessonCompletionHomeButton => 'Back to Home';

  @override
  String get vocabLessonTitle => 'Basic Vocabulary';

  @override
  String vocabLessonProgress(Object current, Object total) {
    return 'Question $current/$total';
  }

  @override
  String get vocabLessonEmpty => 'No questions';

  @override
  String vocabLessonError(Object message) {
    return 'Error: $message';
  }

  @override
  String get vocabLessonFeedbackCorrect => 'Correct!';

  @override
  String get vocabLessonFeedbackWrong => 'Wrong!';

  @override
  String get vocabLessonExplanationTitle => 'Explanation';

  @override
  String get vocabLessonSaveButton => 'Save Word';

  @override
  String get vocabLessonNextButton => 'Continue';

  @override
  String get vocabLessonResultPassedTitle => 'Excellent! ';

  @override
  String get vocabLessonResultFailedTitle => 'Keep Trying! ';

  @override
  String get vocabLessonResultPassedMessage => 'You have passed the test!';

  @override
  String get vocabLessonResultFailedMessage => 'Try again for a better result';

  @override
  String get vocabLessonResultScoreLabel => 'score';

  @override
  String get vocabLessonResultCorrectLabel => 'Correct';

  @override
  String get vocabLessonResultWrongLabel => 'Wrong';

  @override
  String get vocabLessonResultTotalLabel => 'Total';

  @override
  String get vocabLessonResultCompleteButton => 'Complete';

  @override
  String get guestButtonLabel => 'Continue as guest';

  @override
  String get loadingIndicatorText => 'Logging in...';

  @override
  String get translLoginGg => 'Sign in with Google';

  @override
  String get translLoginFb => 'Sign in with Facebook';

  @override
  String get loginDividerOr => 'or';

  @override
  String get translWelcome => 'Welcome!';

  @override
  String get translSlogan => 'Learn Vietnamese Together';

  @override
  String get profileDefaultName => 'User';

  @override
  String get profileNoEmail => 'No email';

  @override
  String get profileLogoutTooltip => 'Log out';

  @override
  String get profileStreakTitle => 'Day Streak';

  @override
  String get profileLessonsTitle => 'Lessons';

  @override
  String get profilePointsTitle => 'Points';

  @override
  String get profileSettingsSection => 'Settings & Options';

  @override
  String get profileEditProfile => 'Edit Profile';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profilePrivacy => 'Privacy & Security';

  @override
  String get profileHelp => 'Help & Support';

  @override
  String get profileAbout => 'About App';

  @override
  String get savedVocabTitle => 'Saved Vocabulary';

  @override
  String savedVocabCount(Object count) {
    return '$count words';
  }

  @override
  String get savedVocabSearchHint => 'Search vocabulary...';

  @override
  String get savedVocabDisplayedLabel => 'Displayed';

  @override
  String get savedVocabTotalLabel => 'Total words';

  @override
  String get savedVocabEmptyTitle => 'No vocabulary yet';

  @override
  String get savedVocabEmptySubtitle => 'Start saving your vocabulary';

  @override
  String get savedVocabNoResultTitle => 'No words found';

  @override
  String get savedVocabNoResultSubtitle => 'Try searching with different keywords';

  @override
  String get aboutTitle => 'About App';

  @override
  String get aboutAppName => 'HiHear Mo';

  @override
  String get aboutVersion => 'Version 1.0.0';

  @override
  String get aboutDescription => 'HiHear Mo is a Vietnamese learning app designed for foreigners, helping you easily access the Vietnamese language and culture through engaging grammar, vocabulary, and pronunciation lessons.';

  @override
  String get aboutDeveloper => 'Developer';

  @override
  String get aboutDeveloperValue => 'HiHear Team';

  @override
  String get aboutEmail => 'Contact Email';

  @override
  String get aboutEmailValue => 'support@hihearmo.com';

  @override
  String get aboutWebsite => 'Website';

  @override
  String get aboutWebsiteValue => 'www.hihearmo.com';

  @override
  String get aboutFeaturesTitle => 'Key Features';

  @override
  String get aboutFeatureVocab => 'Learn Vietnamese vocabulary';

  @override
  String get aboutFeaturePronunciation => 'Practice accurate pronunciation';

  @override
  String get aboutFeatureSave => 'Save favorite words';

  @override
  String get aboutFeatureProgress => 'Track your progress';

  @override
  String get aboutCopyright => '© 2025 HiHear Mo. All rights reserved.\nMade with ❤️ in Vietnam';

  @override
  String get helpTitle => 'Help';

  @override
  String get helpUsageGuide => 'Usage Guide';

  @override
  String get helpStartLearning => 'Start Learning';

  @override
  String get helpStartLearningDesc => 'Choose vocabulary or grammar lessons from the Home tab, complete each lesson to unlock the next one.';

  @override
  String get helpVocabManage => 'Manage Vocabulary';

  @override
  String get helpVocabManageDesc => 'In vocabulary lessons, you can save favorite words using the \'Save Word\' button in the feedback after each question.';

  @override
  String get helpSpeakAI => 'Chat with Hearu AI';

  @override
  String get helpSpeakAIDesc => 'Go to the Hearu AI tab to practice free conversation. Press and hold the mic button to speak, release for AI to respond with voice.';

  @override
  String get helpFAQ => 'Frequently Asked Questions';

  @override
  String get helpFAQInternetQ => 'Does the app require an Internet connection?';

  @override
  String get helpFAQInternetA => 'Yes, the app requires an Internet connection to load lessons and use the AI chat feature.';

  @override
  String get helpFAQProgressQ => 'How is learning progress saved?';

  @override
  String get helpFAQProgressA => 'Your progress is automatically saved to your account. You can view your streak and stats in your Profile.';

  @override
  String get helpContact => 'Contact Support';

  @override
  String get helpContactEmail => 'Support Email';

  @override
  String get helpContactWebsite => 'Website';

  @override
  String get helpContactHotline => 'Hotline';

  @override
  String get helpSupportNote => 'We are always here to help!\nIf you encounter any issues or have suggestions, feel free to contact us through the channels above.';

  @override
  String get languageSelectTitle => 'Language';

  @override
  String get languageSelectHeaderTitle => 'Choose Language';

  @override
  String get languageSelectHeaderSubtitle => 'Select your language';

  @override
  String get languageSelectNote => 'Language changes will be applied immediately';

  @override
  String get languageVietnamese => 'Vietnamese';

  @override
  String get languageEnglish => 'English';

  @override
  String get speakPageTitle => 'Pronunciation';

  @override
  String get speakPageSubtitle => 'Learn accurate pronunciation';

  @override
  String get speakPageIntroTitle => 'Let\'s learn Vietnamese pronunciation together!';

  @override
  String get speakPageIntroDesc => 'Listen and practice pronouncing Vietnamese sounds';

  @override
  String get speakPageStartButton => 'START LESSON';

  @override
  String get speakSectionTones => 'Tones';

  @override
  String get speakSectionVowels => 'Vowels';

  @override
  String get speakSectionConsonants => 'Consonants';

  @override
  String get speakSectionDiphthongs => 'Diphthongs';

  @override
  String speakSectionCount(Object count) {
    return '$count sounds';
  }

  @override
  String get speakingLessonTitle => 'Pronunciation Practice';

  @override
  String speakingLessonProgress(Object current, Object total) {
    return 'Sentence $current/$total';
  }

  @override
  String speakingLessonProgressPercent(Object percent) {
    return '$percent%';
  }

  @override
  String speakingLessonLanguage(Object lang) {
    return 'Language: $lang';
  }

  @override
  String get speakingLessonReadPrompt => 'Please read the following sentence:';

  @override
  String get speakingLessonYouSaid => 'You said:';

  @override
  String get speakingLessonErrorNoSpeech => 'No speech detected. Please try again!';

  @override
  String get speakingLessonErrorTitle => 'Error';

  @override
  String get speakingLessonErrorRetry => 'Try Again';

  @override
  String get speakingLessonInitial => 'Initializing...';

  @override
  String get speakingLessonNoLesson => 'No lessons available';

  @override
  String get speakingLessonNoContent => 'Lesson has no content';

  @override
  String get speakingLessonNoSentence => 'No sentences to read';

  @override
  String get speakingLessonFeedbackExcellent => 'Excellent!';

  @override
  String get speakingLessonFeedbackImprove => 'Needs improvement';

  @override
  String get speakingLessonFeedbackMistakes => 'Words to note:';

  @override
  String get speakingLessonFeedbackRetry => 'Try Again';

  @override
  String get speakingLessonFeedbackContinue => 'Continue';

  @override
  String get speakingLessonCompletionTitle => 'Completed!';

  @override
  String get speakingLessonCompletionMessage => 'You have completed all speaking lessons!';

  @override
  String get speakingLessonCompletionHome => 'Back to Home';
}
