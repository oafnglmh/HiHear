import 'package:hihear_mo/data/models/phoneme.dart';

class PhonemeRepository {
  // Nguyên âm
  static const vowels = [
    Phoneme(symbol: 'ɑ', example: 'hot', tts: 'ah'),
    Phoneme(symbol: 'æ', example: 'cat', tts: 'a'),
    Phoneme(symbol: 'ʌ', example: 'but', tts: 'uh'),
    Phoneme(symbol: 'ɛ', example: 'bed', tts: 'e'),
    Phoneme(symbol: 'eɪ', example: 'say', tts: 'ay'),
    Phoneme(symbol: 'ɜ', example: 'bird', tts: 'er'),
    Phoneme(symbol: 'ɪ', example: 'ship', tts: 'i'),
    Phoneme(symbol: 'i', example: 'sheep', tts: 'ee'),
    Phoneme(symbol: 'ə', example: 'about', tts: 'uh'),
    Phoneme(symbol: 'oʊ', example: 'boat', tts: 'oh'),
    Phoneme(symbol: 'ʊ', example: 'foot', tts: 'oo'),
    Phoneme(symbol: 'u', example: 'food', tts: 'ooo'),
    Phoneme(symbol: 'aʊ', example: 'cow', tts: 'ow'),
    Phoneme(symbol: 'aɪ', example: 'time', tts: 'eye'),
    Phoneme(symbol: 'ɔɪ', example: 'boy', tts: 'oy'),
  ];

  // Phụ âm
  static const consonants = [
    Phoneme(symbol: 'p', example: 'pen', tts: 'p'),
    Phoneme(symbol: 'b', example: 'bat', tts: 'b'),
    Phoneme(symbol: 't', example: 'top', tts: 't'),
    Phoneme(symbol: 'd', example: 'dog', tts: 'd'),
    Phoneme(symbol: 'k', example: 'cat', tts: 'k'),
    Phoneme(symbol: 'g', example: 'go', tts: 'g'),
    Phoneme(symbol: 'f', example: 'fish', tts: 'f'),
    Phoneme(symbol: 'v', example: 'van', tts: 'v'),
    Phoneme(symbol: 'θ', example: 'think', tts: 'th'),
    Phoneme(symbol: 'ð', example: 'this', tts: 'th'),
    Phoneme(symbol: 's', example: 'see', tts: 's'),
    Phoneme(symbol: 'z', example: 'zoo', tts: 'z'),
    Phoneme(symbol: 'ʃ', example: 'she', tts: 'sh'),
    Phoneme(symbol: 'ʒ', example: 'measure', tts: 'zh'),
    Phoneme(symbol: 'h', example: 'hat', tts: 'h'),
    Phoneme(symbol: 'm', example: 'man', tts: 'm'),
    Phoneme(symbol: 'n', example: 'net', tts: 'n'),
    Phoneme(symbol: 'ŋ', example: 'sing', tts: 'ng'),
    Phoneme(symbol: 'l', example: 'leg', tts: 'l'),
    Phoneme(symbol: 'r', example: 'red', tts: 'r'),
    Phoneme(symbol: 'j', example: 'yes', tts: 'y'),
    Phoneme(symbol: 'w', example: 'we', tts: 'w'),
    Phoneme(symbol: 'tʃ', example: 'chair', tts: 'ch'),
    Phoneme(symbol: 'dʒ', example: 'jump', tts: 'j'),
  ];
}
