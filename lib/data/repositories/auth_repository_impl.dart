import 'package:google_sign_in/google_sign_in.dart';
import 'package:real_social_app/core/api_keys.dart';
import 'package:real_social_app/core/mixins.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl with LoggerMixin, SupabaseHelperMixin {
  final SupabaseClient client;

  AuthRepositoryImpl({required this.client});

  /// Fetches the current authenticated user from Supabase.
  ///
  User? get currentUser => client.auth.currentUser;

  /// Handles the sign-in process with Google.
  /// Uses the [GoogleSignIn] package to initiate the sign-in flow.
  final _googleSignIn = GoogleSignIn(
    clientId: ApiKeys.iosClientId,
    serverClientId: ApiKeys.webClientId,
  );

  /// Handles the sign-in process with Google and returns an [AuthResponse].
  /// Throws an exception if the sign-in process fails.
  /// If the user cancels the sign-in, it throws an exception with a message.
  /// If the access token or ID token is not found, it throws an exception.
  /// If the user is not found, it throws an exception with a message.
  /// If the sign-in is successful, it returns an [AuthResponse] object.
  Future<AuthResponse> signInWithGoogle() async {
    return await handleSupabaseCall(() async {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled.');
      }
      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw Exception('No Access Token found.');
      }
      if (idToken == null) {
        throw Exception('No ID Token found.');
      }

      final response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw Exception('User not found.');
      }

      return response;
    });
  }

  /// Handles the sign-out process.
  /// Signs out the user from Supabase and Google.
  Future<void> signOut() async {
    await handleSupabaseCall(() async {
      // Sign out from Supabase.
      await client.auth.signOut();

      // Sign out from Google as well.
      await _googleSignIn.signOut();
    });
  }
}
