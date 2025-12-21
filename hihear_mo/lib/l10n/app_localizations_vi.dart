// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'HiHear';

  @override
  String get splashTagline => 'AI hỗ trợ học ngoại ngữ cá nhân hóa';

  @override
  String get dailyGoalQuestion => 'Mục tiêu hằng ngày của bạn là gì nhỉ?';

  @override
  String get minuteLabel => 'Phút';

  @override
  String get dayLabel => 'Ngày';

  @override
  String get difficultyEasy => 'Dễ';

  @override
  String get difficultyMedium => 'Vừa';

  @override
  String get difficultyHard => 'Khó';

  @override
  String get difficultyVeryHard => 'Siêu khó';

  @override
  String get nextButton => 'Tiếp theo';

  @override
  String get startButton => 'Bắt đầu';

  @override
  String get journeyStartMessage => 'Cùng bắt đầu hành trình học tập của bạn nào!';

  @override
  String get seriesOfDays => 'Chuỗi ngày';

  @override
  String get level => 'Cấp độ';

  @override
  String get settingAccountSection => 'Tài khoản';

  @override
  String get settingPersonalInfo => 'Thông tin cá nhân';

  @override
  String get settingLogout => 'Đăng xuất';

  @override
  String get settingAppSection => 'Ứng dụng';

  @override
  String get settingLanguage => 'Ngôn ngữ';

  @override
  String get settingNotification => 'Thông báo';

  @override
  String get settingOtherSection => 'Khác';

  @override
  String get settingHelpSupport => 'Trợ giúp & Hỗ trợ';

  @override
  String get settingAboutApp => 'Giới thiệu ứng dụng';

  @override
  String get countrySelectionTitle => 'Chọn quốc gia';

  @override
  String get countrySelectionSubtitle => '🇻🇳 Bạn đến từ đâu?';

  @override
  String get loadingText => 'Đang tải...';

  @override
  String get noCountryFound => 'Không tìm thấy quốc gia';

  @override
  String get confirmButton => 'Xác nhận';

  @override
  String get levelCheckTitle => 'Kiểm tra trình độ';

  @override
  String get levelCheckSubtitle => 'Chọn ngôn ngữ bài kiểm tra 🪷';

  @override
  String get levelCheckQuestion => 'Hãy chọn ngôn ngữ để bắt đầu bài kiểm tra trình độ tiếng Việt của bạn!';

  @override
  String get englishTestTitle => 'English Test';

  @override
  String get englishTestSubtitle => 'Kiểm tra bằng tiếng Anh';

  @override
  String get koreanTestTitle => 'Korean Test';

  @override
  String get koreanTestSubtitle => '한국어로 시험보기';

  @override
  String get vietnameseLanguage => 'Tiếng Việt';

  @override
  String get testSelectAnswerWarning => 'Vui lòng chọn một đáp án!';

  @override
  String get testCongratulations => 'Chúc mừng!';

  @override
  String testPassedLevel(Object level) {
    return 'Bạn đã vượt qua cấp độ $level';
  }

  @override
  String get testScore => 'Điểm';

  @override
  String get testReadyNextChallenge => 'Sẵn sàng cho thử thách tiếp theo?';

  @override
  String get testContinue => 'Tiếp tục';

  @override
  String get testExcellent => '🌟 Xuất sắc!';

  @override
  String get testKeepTrying => '💪 Cố gắng lên!';

  @override
  String get testYourLevel => 'Trình độ của bạn:';

  @override
  String get testNotReached => 'Chưa đạt';

  @override
  String get testReached => 'Đạt';

  @override
  String get testLevelScore => 'Điểm';

  @override
  String get testCompleted => 'Đã hoàn thành:';

  @override
  String get testFinish => 'Hoàn thành';

  @override
  String get testLoading => 'Đang tải bài test...';

  @override
  String get testQuestion => 'Câu';

  @override
  String get testNextQuestion => 'Câu tiếp theo';

  @override
  String get aiChatReadyToChat => 'Sẵn sàng trò chuyện';

  @override
  String get aiChatListening => 'Đang lắng nghe...';

  @override
  String get aiChatThinking => 'Đang suy nghĩ...';

  @override
  String get aiChatSpeaking => 'Đang trả lời...';

  @override
  String get aiChatListeningNow => 'Đang nghe...';

  @override
  String get aiChatRecognized => 'Đã nhận';

  @override
  String get aiChatSaySomething => 'Hãy nói điều gì đó...';

  @override
  String get aiChatErrorSpeechRecognition => 'Lỗi nhận diện giọng nói';

  @override
  String get aiChatErrorSpeechNotAvailable => 'Không thể khởi động nhận diện giọng nói';

  @override
  String get homeTabHome => 'Trang chủ';

  @override
  String get homeTabSpeak => 'Luyện nói';

  @override
  String get homeTabAi => 'Hearu AI';

  @override
  String get homeTabSavedVocab => 'Từ vựng đã lưu';

  @override
  String get homeTabProfile => 'Hồ sơ';

  @override
  String streakPopupTitle(Object streakDays) {
    return 'Chuỗi $streakDays ngày!';
  }

  @override
  String get streakPopupMessage => 'Tuyệt vời! Tiếp tục phát huy nhé!';

  @override
  String get streakPopupButton => 'Tiếp tục học';

  @override
  String get lessonPathLevelHeader => 'SECTION 1, UNIT 1';

  @override
  String get lessonPathLockedDialogTitle => 'Bài học bị khóa';

  @override
  String get lessonPathLockedDialogContent => 'Bạn cần hoàn thành các bài học trước đó để mở khóa bài học này.';

  @override
  String get lessonPathLockedDialogButton => 'Đã hiểu';

  @override
  String get homeHeaderGreeting => 'Xin chào!';

  @override
  String get homeHeaderSubtitle => 'Học tiếng Việt thôi nào!';

  @override
  String get grammarLessonAppBarTitle => 'Học Ngữ Pháp';

  @override
  String grammarLessonProgressSentence(Object current, Object total) {
    return 'Câu $current/$total';
  }

  @override
  String grammarLessonProgressPercent(Object percent) {
    return '$percent%';
  }

  @override
  String get grammarLessonLevelEasy => 'Dễ';

  @override
  String get grammarLessonCategoryGrammar => 'Ngữ pháp';

  @override
  String get grammarLessonDefaultTitle => 'Bài học';

  @override
  String get grammarLessonGrammarRuleTitle => 'Quy tắc ngữ pháp';

  @override
  String get grammarLessonExampleTitle => 'Ví dụ';

  @override
  String get grammarLessonTranslationTitle => 'Dịch nghĩa';

  @override
  String get grammarLessonPreviousButton => 'Trước';

  @override
  String get grammarLessonNextButton => 'Tiếp theo';

  @override
  String get grammarLessonCompleteButton => 'Hoàn thành';

  @override
  String get grammarLessonEmptyTitle => 'Không có nội dung ngữ pháp';

  @override
  String get grammarLessonErrorTitle => 'Đã có lỗi xảy ra';

  @override
  String get grammarLessonErrorRetryButton => 'Thử lại';

  @override
  String get grammarLessonCompletionTitle => 'Chúc mừng!';

  @override
  String get grammarLessonCompletionMessage => 'Bạn đã hoàn thành bài học ngữ pháp này.';

  @override
  String get grammarLessonCompletionHomeButton => 'Quay về trang chủ';

  @override
  String get vocabLessonTitle => 'Từ vựng cơ bản';

  @override
  String vocabLessonProgress(Object current, Object total) {
    return 'Câu $current/$total';
  }

  @override
  String get vocabLessonEmpty => 'Không có câu hỏi';

  @override
  String vocabLessonError(Object message) {
    return 'Lỗi: $message';
  }

  @override
  String get vocabLessonFeedbackCorrect => 'Chính xác!';

  @override
  String get vocabLessonFeedbackWrong => 'Sai rồi!';

  @override
  String get vocabLessonExplanationTitle => 'Giải thích';

  @override
  String get vocabLessonSaveButton => 'Lưu từ';

  @override
  String get vocabLessonNextButton => 'Tiếp tục';

  @override
  String get vocabLessonResultPassedTitle => 'Xuất sắc! ';

  @override
  String get vocabLessonResultFailedTitle => 'Cố gắng lên! ';

  @override
  String get vocabLessonResultPassedMessage => 'Bạn đã vượt qua bài kiểm tra!';

  @override
  String get vocabLessonResultFailedMessage => 'Hãy thử lại để đạt kết quả tốt hơn';

  @override
  String get vocabLessonResultScoreLabel => 'điểm số';

  @override
  String get vocabLessonResultCorrectLabel => 'Đúng';

  @override
  String get vocabLessonResultWrongLabel => 'Sai';

  @override
  String get vocabLessonResultTotalLabel => 'Tổng';

  @override
  String get vocabLessonResultCompleteButton => 'Hoàn thành';

  @override
  String get guestButtonLabel => 'Tiếp tục với tư cách khách';

  @override
  String get loadingIndicatorText => 'Đang đăng nhập...';

  @override
  String get translLoginGg => 'Đăng nhập bằng Google';

  @override
  String get translLoginFb => 'Đăng nhập bằng Facebook';

  @override
  String get loginDividerOr => 'hoặc';

  @override
  String get translWelcome => 'Chào mừng bạn!';

  @override
  String get translSlogan => 'Học Tiếng Việt Cùng Nhau';

  @override
  String get profileDefaultName => 'Người dùng';

  @override
  String get profileNoEmail => 'Không có email';

  @override
  String get profileLogoutTooltip => 'Đăng xuất';

  @override
  String get profileStreakTitle => 'Chuỗi ngày';

  @override
  String get profileLessonsTitle => 'Bài học';

  @override
  String get profilePointsTitle => 'Điểm số';

  @override
  String get profileSettingsSection => 'Cài đặt & Tùy chọn';

  @override
  String get profileEditProfile => 'Chỉnh sửa hồ sơ';

  @override
  String get profileNotifications => 'Thông báo';

  @override
  String get profileLanguage => 'Ngôn ngữ';

  @override
  String get profilePrivacy => 'Quyền riêng tư & Bảo mật';

  @override
  String get profileHelp => 'Trợ giúp & Hỗ trợ';

  @override
  String get profileAbout => 'Về ứng dụng';

  @override
  String get savedVocabTitle => 'Từ đã lưu';

  @override
  String savedVocabCount(Object count) {
    return '$count từ vựng';
  }

  @override
  String get savedVocabSearchHint => 'Tìm từ vựng...';

  @override
  String get savedVocabDisplayedLabel => 'Từ hiển thị';

  @override
  String get savedVocabTotalLabel => 'Tổng số từ';

  @override
  String get savedVocabEmptyTitle => 'Chưa có từ vựng nào';

  @override
  String get savedVocabEmptySubtitle => 'Hãy bắt đầu lưu từ vựng của bạn';

  @override
  String get savedVocabNoResultTitle => 'Không tìm thấy từ nào';

  @override
  String get savedVocabNoResultSubtitle => 'Thử tìm kiếm với từ khóa khác';

  @override
  String get aboutTitle => 'Về ứng dụng';

  @override
  String get aboutAppName => 'HiHear Mo';

  @override
  String get aboutVersion => 'Phiên bản 1.0.0';

  @override
  String get aboutDescription => 'HiHear Mo là ứng dụng học tiếng Việt dành cho người nước ngoài, giúp bạn dễ dàng tiếp cận ngôn ngữ và văn hóa Việt Nam qua các bài học ngữ pháp, từ vựng và luyện phát âm một cách thú vị và hiệu quả.';

  @override
  String get aboutDeveloper => 'Nhà phát triển';

  @override
  String get aboutDeveloperValue => 'HiHear Team';

  @override
  String get aboutEmail => 'Email liên hệ';

  @override
  String get aboutEmailValue => 'support@hihearmo.com';

  @override
  String get aboutWebsite => 'Website';

  @override
  String get aboutWebsiteValue => 'www.hihearmo.com';

  @override
  String get aboutFeaturesTitle => 'Tính năng nổi bật';

  @override
  String get aboutFeatureVocab => 'Học từ vựng tiếng Việt';

  @override
  String get aboutFeaturePronunciation => 'Luyện phát âm chuẩn';

  @override
  String get aboutFeatureSave => 'Lưu từ yêu thích';

  @override
  String get aboutFeatureProgress => 'Theo dõi tiến độ';

  @override
  String get aboutCopyright => '© 2025 HiHear Mo. All rights reserved.\nMade with in Vietnam';

  @override
  String get helpTitle => 'Trợ giúp';

  @override
  String get helpUsageGuide => 'Hướng dẫn sử dụng';

  @override
  String get helpStartLearning => 'Bắt đầu học';

  @override
  String get helpStartLearningDesc => 'Chọn các bài học từ vựng hoặc ngữ pháp trong tab Trang chủ, hoàn thành từng bài để mở khóa bài tiếp theo.';

  @override
  String get helpVocabManage => 'Quản lý từ vựng';

  @override
  String get helpVocabManageDesc => 'Trong bài học từ vựng, bạn có thể lưu từ yêu thích bằng nút \'Lưu từ\' ở phần phản hồi sau mỗi câu hỏi.';

  @override
  String get helpSpeakAI => 'Trò chuyện với Hearu AI';

  @override
  String get helpSpeakAIDesc => 'Vào tab Hearu AI để luyện nói tự do. Nhấn giữ nút micro để nói, thả ra để AI trả lời bằng giọng nói.';

  @override
  String get helpFAQ => 'Câu hỏi thường gặp';

  @override
  String get helpFAQInternetQ => 'Ứng dụng có cần kết nối Internet không?';

  @override
  String get helpFAQInternetA => 'Có, ứng dụng yêu cầu kết nối Internet để tải bài học và sử dụng tính năng AI trò chuyện.';

  @override
  String get helpFAQProgressQ => 'Tiến độ học tập được lưu như thế nào?';

  @override
  String get helpFAQProgressA => 'Tiến độ của bạn được lưu tự động trên tài khoản. Bạn có thể xem streak và thống kê trong Hồ sơ.';

  @override
  String get helpContact => 'Liên hệ hỗ trợ';

  @override
  String get helpContactEmail => 'Email hỗ trợ';

  @override
  String get helpContactWebsite => 'Website';

  @override
  String get helpContactHotline => 'Hotline';

  @override
  String get helpSupportNote => 'Chúng tôi luôn sẵn sàng hỗ trợ bạn!\nNếu gặp vấn đề hoặc cần góp ý, đừng ngần ngại liên hệ qua các kênh bên trên.';

  @override
  String get languageSelectTitle => 'Ngôn ngữ';

  @override
  String get languageSelectHeaderTitle => 'Chọn ngôn ngữ';

  @override
  String get languageSelectHeaderSubtitle => 'Select your language';

  @override
  String get languageSelectNote => 'Thay đổi ngôn ngữ sẽ được áp dụng ngay lập tức';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get languageEnglish => 'Tiếng Anh';

  @override
  String get languageKorean => 'Korea';

  @override
  String get speakPageTitle => 'Phát âm';

  @override
  String get speakPageSubtitle => 'Học phát âm chuẩn';

  @override
  String get speakPageIntroTitle => 'Cùng học phát âm tiếng Việt!';

  @override
  String get speakPageIntroDesc => 'Tập nghe và học phát âm các âm trong tiếng Việt';

  @override
  String get speakPageStartButton => 'BẮT ĐẦU BÀI HỌC';

  @override
  String get speakSectionTones => 'Dấu Thanh';

  @override
  String get speakSectionVowels => 'Nguyên âm';

  @override
  String get speakSectionConsonants => 'Phụ âm';

  @override
  String get speakSectionDiphthongs => 'Nguyên âm đôi';

  @override
  String speakSectionCount(Object count) {
    return '$count âm';
  }

  @override
  String get speakingLessonTitle => 'Luyện phát âm';

  @override
  String speakingLessonProgress(Object current, Object total) {
    return 'Câu $current/$total';
  }

  @override
  String speakingLessonProgressPercent(Object percent) {
    return '$percent%';
  }

  @override
  String speakingLessonLanguage(Object lang) {
    return 'Ngôn ngữ: $lang';
  }

  @override
  String get speakingLessonReadPrompt => 'Hãy đọc câu sau:';

  @override
  String get speakingLessonYouSaid => 'Bạn đã nói:';

  @override
  String get speakingLessonErrorNoSpeech => 'Không nhận được giọng nói. Vui lòng thử lại!';

  @override
  String get speakingLessonErrorTitle => 'Lỗi';

  @override
  String get speakingLessonErrorRetry => 'Thử lại';

  @override
  String get speakingLessonInitial => 'Khởi tạo...';

  @override
  String get speakingLessonNoLesson => 'Không có bài học nào';

  @override
  String get speakingLessonNoContent => 'Bài học không có nội dung';

  @override
  String get speakingLessonNoSentence => 'Không có câu để đọc';

  @override
  String get speakingLessonFeedbackExcellent => 'Tuyệt vời!';

  @override
  String get speakingLessonFeedbackImprove => 'Cần cải thiện';

  @override
  String get speakingLessonFeedbackMistakes => 'Từ cần lưu ý:';

  @override
  String get speakingLessonFeedbackRetry => 'Thử lại';

  @override
  String get speakingLessonFeedbackContinue => 'Tiếp tục';

  @override
  String get speakingLessonCompletionTitle => 'Hoàn thành!';

  @override
  String get speakingLessonCompletionMessage => 'Bạn đã hoàn thành tất cả bài học nói!';

  @override
  String get speakingLessonCompletionHome => 'Về trang chủ';

  @override
  String get dailyGoal => 'Đặt mục tiêu hằng ngày';
}
