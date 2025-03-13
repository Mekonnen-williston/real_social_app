import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/data/repositories/auth_repository_impl.dart';
import 'package:real_social_app/data/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provides an instance of AuthRepositoryImpl using SupabaseService.client.
/// 
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(client: SupabaseService.client);
});

/// Provides the current authenticated user from AuthRepositoryImpl.
/// 
final authStateProvider = Provider<User?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.currentUser;
});

/// Provides a stream of authentication state changes.
final authStateStreamProvider = StreamProvider<User?>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange
      .map((data) => data.session?.user);
});