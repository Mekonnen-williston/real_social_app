enum Lango {
  en,
  he;

  String get name => switch (this) {
    Lango.en => 'English', // English
    Lango.he => 'עברית', // Hebrew
  };

  String get code => switch (this) {
    Lango.en => 'en',
    Lango.he => 'he',
  };
}
