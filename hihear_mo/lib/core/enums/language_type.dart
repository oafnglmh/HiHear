import 'package:hihear_mo/domain/entities/country/country_entity.dart';

enum LanguageType {
  vietnamese('vi', 'Tiếng Việt'),
  english('en', 'English'),
  korean('ko', '한국어');

  final String code;
  final String name;
  const LanguageType(this.code, this.name);
}

extension CountryEntityToLanguage on CountryEntity {
  LanguageType toLanguageType() {
    switch (code.toUpperCase()) {
      case 'KR':
      case 'KOREA':
        return LanguageType.korean;
      case 'UK':
      case 'GB':
        return LanguageType.english;
      case 'VN':
      case 'VIETNAM':
        return LanguageType.vietnamese;
      default:
        return LanguageType.english;
    }
  }
}
