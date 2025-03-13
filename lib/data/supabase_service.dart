import 'package:real_social_app/core/api_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// This class is responsible for initializing and providing access to the Supabase client.
///
class SupabaseService {
  /// Initializes the Supabase client with the provided URL and anon key.
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: ApiKeys.supabaseUrl,
      anonKey: ApiKeys.supabaseAnonKey,
    );
  }

  // Expose the client as a singleton.
  static SupabaseClient get client => Supabase.instance.client;
}
