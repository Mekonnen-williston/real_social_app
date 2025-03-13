import 'package:real_social_app/models/word.dart';

extension WordExtensions on Word {
  /// Returns the word formatted in title case.
  String get titleCase {
    return word
        .split(' ')
        .map((str) {
          if (str.isEmpty) return '';
          return '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}';
        })
        .join(' ');
  }

  /// Creates a copy of the Word instance with optional updated values.
  Word copyWith({String? id, String? word, String? userId}) => Word(
    id: id ?? this.id,
    word: word ?? this.word,
    userId: userId ?? this.userId,
  );
}
