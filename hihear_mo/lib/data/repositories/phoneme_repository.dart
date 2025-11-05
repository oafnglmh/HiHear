import 'package:hihear_mo/data/models/phoneme.dart';

class PhonemeRepository {

  static const tones = [
    Phoneme(symbol: '´', example: 'á a', tts: 'sắc'),
    Phoneme(symbol: '`', example: 'à a', tts: 'huyền'),
    Phoneme(symbol: '?', example: 'ả a', tts: 'hỏi'),
    Phoneme(symbol: '~', example: 'ã a', tts: 'ngã'),
    Phoneme(symbol: '.', example: 'ạ a', tts: 'nặng'),
  ];

  // Nguyên âm đơn
  static const vowels = [
    Phoneme(symbol: 'a', example: 'ba ca', tts: 'a'),
    Phoneme(symbol: 'ă', example: 'cắt lúa', tts: 'ă'),
    Phoneme(symbol: 'â', example: 'bần cùng', tts: 'â'),
    Phoneme(symbol: 'e', example: 'tê li', tts: 'e'),
    Phoneme(symbol: 'ê', example: 'kê già', tts: 'ê'),
    Phoneme(symbol: 'i', example: 'bi đi', tts: 'i'),
    Phoneme(symbol: 'o', example: 'bo la', tts: 'o'),
    Phoneme(symbol: 'ô', example: 'cô rô', tts: 'ô'),
    Phoneme(symbol: 'ơ', example: 'cơ sở', tts: 'ơ'),
    Phoneme(symbol: 'u', example: 'buổi học', tts: 'u'),
    Phoneme(symbol: 'ư', example: 'tưới cây', tts: 'ư'),
    Phoneme(symbol: 'y', example: 'ý kiến', tts: 'y'),
  ];

  // Nguyên âm đôi (diphthongs)
  static const diphthongs = [
    Phoneme(symbol: 'ai', example: 'hai con', tts: 'ai'),
    Phoneme(symbol: 'ao', example: 'hao hụt', tts: 'ao'),
    Phoneme(symbol: 'au', example: 'rau muống', tts: 'au'),
    Phoneme(symbol: 'ay', example: 'tay nải', tts: 'ay'),
    Phoneme(symbol: 'âu', example: 'câu hỏi', tts: 'âu'),
    Phoneme(symbol: 'ia', example: 'gia đình', tts: 'ia'),
    Phoneme(symbol: 'iê', example: 'tiên đoán', tts: 'iê'),
    Phoneme(symbol: 'iu', example: 'tiu tiu', tts: 'iu'),
    Phoneme(symbol: 'oa', example: 'hoa loa', tts: 'oa'),
    Phoneme(symbol: 'oă', example: 'thoải mái', tts: 'oă'),
    Phoneme(symbol: 'oe', example: 'thơe thơ', tts: 'oe'),
    Phoneme(symbol: 'oi', example: 'thoi tơi', tts: 'oi'),
    Phoneme(symbol: 'ôi', example: 'hôi thối', tts: 'ôi'),
    Phoneme(symbol: 'ơi', example: 'tơi bời', tts: 'ơi'),
    Phoneme(symbol: 'ua', example: 'tua quay', tts: 'ua'),
    Phoneme(symbol: 'uâ', example: 'quân đội', tts: 'uâ'),
    Phoneme(symbol: 'uê', example: 'huyện uê', tts: 'uê'),
    Phoneme(symbol: 'ui', example: 'cui cui', tts: 'ui'),
    Phoneme(symbol: 'ưu', example: 'ưu tiên', tts: 'ưu'),
    Phoneme(symbol: 'yê', example: 'yên bình', tts: 'yê'),
  ];

  // Phụ âm
  static const consonants = [
    Phoneme(symbol: 'b', example: 'ba ba', tts: 'b'),
    Phoneme(symbol: 'c', example: 'ca ca', tts: 'c'),
    Phoneme(symbol: 'ch', example: 'cha cha', tts: 'ch'),
    Phoneme(symbol: 'd', example: 'da da', tts: 'd'),
    Phoneme(symbol: 'đ', example: 'đá đá', tts: 'đ'),
    Phoneme(symbol: 'g', example: 'ga ga', tts: 'g'),
    Phoneme(symbol: 'gh', example: 'ghế ghế', tts: 'gh'),
    Phoneme(symbol: 'h', example: 'ha ha', tts: 'h'),
    Phoneme(symbol: 'k', example: 'ka ka', tts: 'k'),
    Phoneme(symbol: 'l', example: 'la la', tts: 'l'),
    Phoneme(symbol: 'm', example: 'ma ma', tts: 'm'),
    Phoneme(symbol: 'n', example: 'na na', tts: 'n'),
    Phoneme(symbol: 'nh', example: 'nhà nhà', tts: 'nh'),
    Phoneme(symbol: 'ng', example: 'ngà ngà', tts: 'ng'),
    Phoneme(symbol: 'ngh', example: 'nghê nghê', tts: 'ngh'),
    Phoneme(symbol: 'p', example: 'pa pa', tts: 'p'),
    Phoneme(symbol: 'q', example: 'qua qua', tts: 'q'),
    Phoneme(symbol: 'r', example: 'ra ra', tts: 'r'),
    Phoneme(symbol: 's', example: 'sa sa', tts: 's'),
    Phoneme(symbol: 't', example: 'ta ta', tts: 't'),
    Phoneme(symbol: 'th', example: 'tha tha', tts: 'th'),
    Phoneme(symbol: 'tr', example: 'tra tra', tts: 'tr'),
    Phoneme(symbol: 'v', example: 'va va', tts: 'v'),
    Phoneme(symbol: 'x', example: 'xa xa', tts: 'x'),
  ];

  
}
