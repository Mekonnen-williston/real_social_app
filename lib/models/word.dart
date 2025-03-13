class Word {
  final String id;
  final String word;
  final String userId;

  /// Constructor for the Word class.
  Word({required this.id, required this.word, required this.userId});

  /// Factory constructor to create a Word instance from a map.
  factory Word.fromMap(Map<String, dynamic> map) => Word(
    id: map['id'] as String,
    word: map['word'] as String,
    userId: map['user_id'] as String,
  );

  /// Method to convert the Word instance to a map.
  Map<String, dynamic> toJson() => {'id': id, 'word': word, 'user_id': userId};
}
