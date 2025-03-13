import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/word_repository_impl.dart';
import '../../data/supabase_service.dart';
import '../../models/word.dart';
import 'auth_provider.dart';

/// Provides an instance of WordRepositoryImpl using SupabaseService.client.
///
/// It allows adding, and counting favorite words.
/// It also provides a stream of favorite words for the current user.
///
final wordRepositoryProvider = Provider<WordRepositoryImpl>((ref) {
  return WordRepositoryImpl(client: SupabaseService.client);
});

/// Provides a stream of favorite words for the current user.
///
final favoriteWordsStreamProvider = StreamProvider<List<Word>>((ref) {
  final authAsync = ref.watch(authStateStreamProvider);
  return authAsync.when(
    data: (user) {
      if (user == null) {
        return const Stream.empty();
      }
      final repository = ref.watch(wordRepositoryProvider);
      return repository.watchFavoriteWords(user.id);
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});
