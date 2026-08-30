enum LanguageCode {
  cs,
  de,
  en,
  es,
  fr,
  hu,
  id,
  it,
  ja,
  ko,
  pl,
  pt,
  ro,
  ru,
  sk,
  th,
  tr,
  vn,
  zh;

  String get code => name;

  static LanguageCode? tryParse(String? value) {
    if (value == null) return null;
    for (final language in values) {
      if (language.name == value) return language;
    }
    return null;
  }
}
