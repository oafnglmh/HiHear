// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'HiHear';

  @override
  String get splashTagline => '개인화된 AI 언어 학습';

  @override
  String get dailyGoalQuestion => '오늘 목표는 무엇인가요?';

  @override
  String get minuteLabel => '분';

  @override
  String get dayLabel => '일';

  @override
  String get difficultyEasy => '쉬움';

  @override
  String get difficultyMedium => '보통';

  @override
  String get difficultyHard => '어려움';

  @override
  String get difficultyVeryHard => '매우 어려움';

  @override
  String get nextButton => '다음';

  @override
  String get startButton => '시작';

  @override
  String get journeyStartMessage => '학습 여정을 시작해 볼까요!';

  @override
  String get seriesOfDays => '연속 일수';

  @override
  String get level => '레벨';

  @override
  String get settingAccountSection => '계정';

  @override
  String get settingPersonalInfo => '개인 정보';

  @override
  String get settingLogout => '로그아웃';

  @override
  String get settingAppSection => '앱';

  @override
  String get settingLanguage => '언어';

  @override
  String get settingNotification => '알림';

  @override
  String get settingOtherSection => '기타';

  @override
  String get settingHelpSupport => '도움말 및 지원';

  @override
  String get settingAboutApp => '앱 정보';

  @override
  String get countrySelectionTitle => '국가 선택';

  @override
  String get countrySelectionSubtitle => '🇻🇳 어디에서 오셨나요?';

  @override
  String get loadingText => '로딩 중...';

  @override
  String get noCountryFound => '국가를 찾을 수 없음';

  @override
  String get confirmButton => '확인';

  @override
  String get levelCheckTitle => '레벨 테스트';

  @override
  String get levelCheckSubtitle => '테스트 언어 선택 🪷';

  @override
  String get levelCheckQuestion => '베트남어 실력 테스트를 시작할 언어를 선택해 주세요!';

  @override
  String get englishTestTitle => '영어 테스트';

  @override
  String get englishTestSubtitle => '영어로 테스트하기';

  @override
  String get koreanTestTitle => '한국어 테스트';

  @override
  String get koreanTestSubtitle => '한국어로 시험보기';

  @override
  String get vietnameseLanguage => '베트남어';

  @override
  String get testSelectAnswerWarning => '답변을 선택해 주세요!';

  @override
  String get testCongratulations => '축하합니다!';

  @override
  String get testPassedLevel => '통과했습니다';

  @override
  String get testScore => '점수';

  @override
  String get testReadyNextChallenge => '다음 도전에 준비되셨나요?';

  @override
  String get testContinue => '계속';

  @override
  String get testExcellent => '🌟 훌륭합니다!';

  @override
  String get testKeepTrying => '💪 계속 노력하세요!';

  @override
  String get testYourLevel => '당신의 레벨:';

  @override
  String get testNotReached => '미달';

  @override
  String get testReached => '달성';

  @override
  String get testLevelScore => '점수';

  @override
  String get testCompleted => '완료:';

  @override
  String get testFinish => '완료';

  @override
  String get testLoading => '테스트 로딩 중...';

  @override
  String get testQuestion => '문제';

  @override
  String get testNextQuestion => '다음 문제';

  @override
  String get aiChatReadyToChat => '대화 준비 완료';

  @override
  String get aiChatListening => '듣는 중...';

  @override
  String get aiChatThinking => '생각 중...';

  @override
  String get aiChatSpeaking => '말하는 중...';

  @override
  String get aiChatListeningNow => '지금 듣는 중...';

  @override
  String get aiChatRecognized => '인식됨';

  @override
  String get aiChatSaySomething => '무언가 말해 보세요...';

  @override
  String get aiChatErrorSpeechRecognition => '음성 인식 오류';

  @override
  String get aiChatErrorSpeechNotAvailable => '음성 인식을 시작할 수 없음';

  @override
  String get homeTabHome => '홈';

  @override
  String get homeTabSpeak => '말하기 연습';

  @override
  String get homeTabAi => 'Hearu AI';

  @override
  String get homeTabSavedVocab => '저장된 단어';

  @override
  String get homeTabProfile => '프로필';

  @override
  String streakPopupTitle(Object streakDays) {
    return '$streakDays일 연속!';
  }

  @override
  String get streakPopupMessage => '멋져요! 계속 화이팅!';

  @override
  String get streakPopupButton => '학습 계속하기';

  @override
  String get lessonPathLevelHeader => 'SECTION 1, UNIT 1';

  @override
  String get lessonPathLockedDialogTitle => '잠긴 레슨';

  @override
  String get lessonPathLockedDialogContent => '이 레슨을 해제하려면 이전 레슨을 완료해야 합니다.';

  @override
  String get lessonPathLockedDialogButton => '알겠습니다';

  @override
  String get homeHeaderGreeting => '안녕하세요!';

  @override
  String get homeHeaderSubtitle => '베트남어 공부해요!';

  @override
  String get grammarLessonAppBarTitle => '문법 학습';

  @override
  String grammarLessonProgressSentence(Object current, Object total) {
    return '문장 $current/$total';
  }

  @override
  String grammarLessonProgressPercent(Object percent) {
    return '$percent%';
  }

  @override
  String get grammarLessonLevelEasy => '쉬움';

  @override
  String get grammarLessonCategoryGrammar => '문법';

  @override
  String get grammarLessonDefaultTitle => '레슨';

  @override
  String get grammarLessonGrammarRuleTitle => '문법 규칙';

  @override
  String get grammarLessonExampleTitle => '예시';

  @override
  String get grammarLessonTranslationTitle => '번역';

  @override
  String get grammarLessonPreviousButton => '이전';

  @override
  String get grammarLessonNextButton => '다음';

  @override
  String get grammarLessonCompleteButton => '완료';

  @override
  String get grammarLessonEmptyTitle => '문법 콘텐츠 없음';

  @override
  String get grammarLessonErrorTitle => '오류 발생';

  @override
  String get grammarLessonErrorRetryButton => '다시 시도';

  @override
  String get grammarLessonCompletionTitle => '축하합니다!';

  @override
  String get grammarLessonCompletionMessage => '이 문법 레슨을 완료했습니다.';

  @override
  String get grammarLessonCompletionHomeButton => '홈으로 돌아가기';

  @override
  String get vocabLessonTitle => '기본 단어';

  @override
  String vocabLessonProgress(Object current, Object total) {
    return '문제 $current/$total';
  }

  @override
  String get vocabLessonEmpty => '문제 없음';

  @override
  String vocabLessonError(Object message) {
    return '오류: $message';
  }

  @override
  String get vocabLessonFeedbackCorrect => '정답!';

  @override
  String get vocabLessonFeedbackWrong => '오답!';

  @override
  String get vocabLessonExplanationTitle => '설명';

  @override
  String get vocabLessonSaveButton => '단어 저장';

  @override
  String get vocabLessonNextButton => '계속';

  @override
  String get vocabLessonResultPassedTitle => '훌륭합니다! ';

  @override
  String get vocabLessonResultFailedTitle => '계속 노력하세요! ';

  @override
  String get vocabLessonResultPassedMessage => '테스트에 합격했습니다!';

  @override
  String get vocabLessonResultFailedMessage => '더 좋은 결과를 위해 다시 시도해 보세요';

  @override
  String get vocabLessonResultScoreLabel => '점수';

  @override
  String get vocabLessonResultCorrectLabel => '정답';

  @override
  String get vocabLessonResultWrongLabel => '오답';

  @override
  String get vocabLessonResultTotalLabel => '총합';

  @override
  String get vocabLessonResultCompleteButton => '완료';

  @override
  String get guestButtonLabel => '게스트로 계속하기';

  @override
  String get loadingIndicatorText => '로그인 중...';

  @override
  String get translLoginGg => 'Google로 로그인';

  @override
  String get translLoginFb => 'Facebook으로 로그인';

  @override
  String get loginDividerOr => '또는';

  @override
  String get translWelcome => '환영합니다!';

  @override
  String get translSlogan => '함께 베트남어 배우기';

  @override
  String get profileDefaultName => '사용자';

  @override
  String get profileNoEmail => '이메일 없음';

  @override
  String get profileLogoutTooltip => '로그아웃';

  @override
  String get profileStreakTitle => '연속 일수';

  @override
  String get profileLessonsTitle => '레슨';

  @override
  String get profilePointsTitle => '포인트';

  @override
  String get profileSettingsSection => '설정 및 옵션';

  @override
  String get profileEditProfile => '프로필 수정';

  @override
  String get profileNotifications => '알림';

  @override
  String get profileLanguage => '언어';

  @override
  String get profilePrivacy => '개인정보 보호 및 보안';

  @override
  String get profileHelp => '도움말 및 지원';

  @override
  String get profileAbout => '앱 정보';

  @override
  String get savedVocabTitle => '저장된 단어';

  @override
  String savedVocabCount(Object count) {
    return '$count 단어';
  }

  @override
  String get savedVocabSearchHint => '단어 검색...';

  @override
  String get savedVocabDisplayedLabel => '표시된 단어';

  @override
  String get savedVocabTotalLabel => '총 단어 수';

  @override
  String get savedVocabEmptyTitle => '아직 저장된 단어가 없어요';

  @override
  String get savedVocabEmptySubtitle => '단어 저장을 시작해 보세요';

  @override
  String get savedVocabNoResultTitle => '단어를 찾을 수 없음';

  @override
  String get savedVocabNoResultSubtitle => '다른 키워드로 검색해 보세요';

  @override
  String get aboutTitle => '앱 정보';

  @override
  String get aboutAppName => 'HiHear Mo';

  @override
  String get aboutVersion => '버전 1.0.0';

  @override
  String get aboutDescription => 'HiHear Mo는 외국인을 위한 베트남어 학습 앱으로, 흥미롭고 효과적인 문법, 단어, 발음 레슨을 통해 베트남어와 문화를 쉽게 접할 수 있게 도와줍니다.';

  @override
  String get aboutDeveloper => '개발자';

  @override
  String get aboutDeveloperValue => 'HiHear Team';

  @override
  String get aboutEmail => '연락처 이메일';

  @override
  String get aboutEmailValue => 'support@hihearmo.com';

  @override
  String get aboutWebsite => '웹사이트';

  @override
  String get aboutWebsiteValue => 'www.hihearmo.com';

  @override
  String get aboutFeaturesTitle => '주요 기능';

  @override
  String get aboutFeatureVocab => '베트남어 단어 학습';

  @override
  String get aboutFeaturePronunciation => '정확한 발음 연습';

  @override
  String get aboutFeatureSave => '좋아하는 단어 저장';

  @override
  String get aboutFeatureProgress => '학습 진행 상황 추적';

  @override
  String get aboutCopyright => '© 2025 HiHear Mo. All rights reserved.\nMade with ❤️ in Vietnam';

  @override
  String get helpTitle => '도움말';

  @override
  String get helpUsageGuide => '사용 가이드';

  @override
  String get helpStartLearning => '학습 시작하기';

  @override
  String get helpStartLearningDesc => '홈 탭에서 단어나 문법 레슨을 선택하고, 하나씩 완료하여 다음 레슨을 해제하세요.';

  @override
  String get helpVocabManage => '단어 관리';

  @override
  String get helpVocabManageDesc => '단어 레슨에서 각 문제 후 피드백의 \'단어 저장\' 버튼으로 좋아하는 단어를 저장할 수 있습니다.';

  @override
  String get helpSpeakAI => 'Hearu AI와 대화하기';

  @override
  String get helpSpeakAIDesc => 'Hearu AI 탭으로 이동하여 자유롭게 말하기 연습하세요. 마이크 버튼을 길게 누르면 말하고, 놓으면 AI가 음성으로 답변합니다.';

  @override
  String get helpFAQ => '자주 묻는 질문';

  @override
  String get helpFAQInternetQ => '인터넷 연결이 필요한가요?';

  @override
  String get helpFAQInternetA => '네, 레슨 로드와 AI 채팅 기능을 사용하려면 인터넷 연결이 필요합니다.';

  @override
  String get helpFAQProgressQ => '학습 진행 상황은 어떻게 저장되나요?';

  @override
  String get helpFAQProgressA => '진행 상황은 계정에 자동 저장됩니다. 프로필에서 연속 일수와 통계를 확인할 수 있습니다.';

  @override
  String get helpContact => '지원 문의';

  @override
  String get helpContactEmail => '지원 이메일';

  @override
  String get helpContactWebsite => '웹사이트';

  @override
  String get helpContactHotline => '핫라인';

  @override
  String get helpSupportNote => '항상 도와드릴 준비가 되어 있습니다!\n문제나 제안 사항이 있으면 위 채널을 통해 언제든 연락 주세요.';

  @override
  String get languageSelectTitle => '언어';

  @override
  String get languageSelectHeaderTitle => '언어 선택';

  @override
  String get languageSelectHeaderSubtitle => '언어를 선택하세요';

  @override
  String get languageSelectNote => '언어 변경은 즉시 적용됩니다';

  @override
  String get languageVietnamese => '베트남어';

  @override
  String get languageEnglish => '영어';

  @override
  String get speakPageTitle => '발음';

  @override
  String get speakPageSubtitle => '정확한 발음 배우기';

  @override
  String get speakPageIntroTitle => '베트남어 발음을 함께 배워요!';

  @override
  String get speakPageIntroDesc => '베트남어 소리를 듣고 발음 연습하기';

  @override
  String get speakPageStartButton => '레슨 시작';

  @override
  String get speakSectionTones => '성조';

  @override
  String get speakSectionVowels => '모음';

  @override
  String get speakSectionConsonants => '자음';

  @override
  String get speakSectionDiphthongs => '이중 모음';

  @override
  String speakSectionCount(Object count) {
    return '$count 소리';
  }

  @override
  String get speakingLessonTitle => '발음 연습';

  @override
  String speakingLessonProgress(Object current, Object total) {
    return '문장 $current/$total';
  }

  @override
  String speakingLessonProgressPercent(Object percent) {
    return '$percent%';
  }

  @override
  String speakingLessonLanguage(Object lang) {
    return '언어: $lang';
  }

  @override
  String get speakingLessonReadPrompt => '다음 문장을 읽어 주세요:';

  @override
  String get speakingLessonYouSaid => '당신이 말한 내용:';

  @override
  String get speakingLessonErrorNoSpeech => '음성이 감지되지 않았습니다. 다시 시도해 주세요!';

  @override
  String get speakingLessonErrorTitle => '오류';

  @override
  String get speakingLessonErrorRetry => '다시 시도';

  @override
  String get speakingLessonInitial => '초기화 중...';

  @override
  String get speakingLessonNoLesson => '레슨이 없습니다';

  @override
  String get speakingLessonNoContent => '레슨에 내용이 없습니다';

  @override
  String get speakingLessonNoSentence => '읽을 문장이 없습니다';

  @override
  String get speakingLessonFeedbackExcellent => '훌륭합니다!';

  @override
  String get speakingLessonFeedbackImprove => '개선이 필요합니다';

  @override
  String get speakingLessonFeedbackMistakes => '주의할 단어:';

  @override
  String get speakingLessonFeedbackRetry => '다시 시도';

  @override
  String get speakingLessonFeedbackContinue => '계속';

  @override
  String get speakingLessonCompletionTitle => '완료!';

  @override
  String get speakingLessonCompletionMessage => '모든 말하기 레슨을 완료했습니다!';

  @override
  String get speakingLessonCompletionHome => '홈으로 돌아가기';
}
