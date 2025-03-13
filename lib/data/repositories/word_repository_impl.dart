import 'package:real_social_app/core/database_constants.dart';
import 'package:real_social_app/core/mixins.dart';
import 'package:real_social_app/models/word.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A repository class that handles operations related to words in the
/// Supabase database.
///
class WordRepositoryImpl with LoggerMixin, SupabaseHelperMixin {
  final SupabaseClient client;

  WordRepositoryImpl({required this.client});

  /// Fetches the current authenticated user from Supabase.
  ///
  User? get currentUser => client.auth.currentUser;

  /// Watches the favorite words of a user as a stream.
  ///
  /// Returns a stream of a list of Word objects.
  Stream<List<Word>> watchFavoriteWords(String userId) {
    return client
        .from(DBConstants.favoriteWordsTable)
        .stream(primaryKey: [DBConstants.idColumn])
        .eq(DBConstants.userIdColumn, userId)
        .map((data) => data.map((map) => Word.fromMap(map)).toList());
  }

  /// Adds a word to the user's favorite words list.
  ///
  /// Takes the word text and user ID as parameters.
  Future<void> addWord(String text) async {
    await handleSupabaseCall(() async {
      await client.from(DBConstants.favoriteWordsTable).insert({
        DBConstants.wordColumn: text,
        DBConstants.userIdColumn: currentUser!.id,
      });
    });
  }

  /// Gets the count of favorite words for a user.
  ///
  /// Returns the count as an integer.
  Future<int> getWordCount() async {
    // Include the count option so the response contains a count property.
    final int count = await handleSupabaseCall(() async {
      return await client
          .from(DBConstants.favoriteWordsTable)
          .count()
          .eq(DBConstants.userIdColumn, currentUser!.id);
    });
    return count;
  }

  /// Deletes a word from the user's favorite words list.
  ///
  /// Takes the word ID as a parameter.
  Future<void> deleteWord(String id) async {
    await handleSupabaseCall(() async {
      await client
          .from(DBConstants.favoriteWordsTable)
          .delete()
          .eq(DBConstants.idColumn, id);
    });
  }
}
