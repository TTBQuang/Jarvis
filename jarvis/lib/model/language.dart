enum Language {
  auto('Auto', 'Let AI choose the language'),
  indonesian('Indonesian', 'Bahasa Indonesia'),
  czech('Czech', 'Čeština'),
  german('German', 'Deutsch'),
  english('English', 'English'),
  spanish('Spanish', 'Español'),
  spanishLatam('Spanish (Latin America and Caribbean)', 'Español (Latinoamérica y el Caribe)'),
  french('French', 'Français'),
  italian('Italian', 'Italiano'),
  dutch('Dutch', 'Nederlands'),
  portugueseBrazil('Portuguese (Brasil)', 'Português (Brasil)'),
  portuguesePortugal('Portuguese (Portugal)', 'Português (Portugal)'),
  polish('Polish', 'Polski'),
  russian('Russian', 'Русский'),
  vietnamese('Vietnamese', 'Tiếng Việt'),
  turkish('Turkish', 'Türkçe'),
  ukrainian('Ukrainian', 'Українська'),
  chineseSimplified('Chinese (Simplified)', '简体中文'),
  chineseTaiwan('Chinese (Taiwan)', '繁體中文'),
  chineseHongKong('Chinese (Hong Kong)', '繁體中文（香港）'),
  japanese('Japanese', '日本語'),
  korean('Korean', '한국어'),
  arabic('Arabic', 'العربية'),
  persian('Persian', 'فارسی'),
  thai('Thai', 'ไทย'),
  hindi('Hindi', 'हिन्दी');

  final String englishName;
  final String nativeName;

  const Language(this.englishName, this.nativeName);

  static Language fromString(String language) {
    return Language.values.firstWhere(
          (e) => e.englishName == language,
      orElse: () => Language.auto,
    );
  }
}