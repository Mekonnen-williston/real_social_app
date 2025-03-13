/// This class contains the API keys for the application.
/// It includes the Supabase URL and anon key,
/// as well as the OAuth client IDs for Google Sign-In.
///
class ApiKeys {
  /// The API key for the Supabase service
  static const String supabaseUrl = 'https://zcpmqbskotxgsisskwsu.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpjcG1xYnNrb3R4Z3Npc3Nrd3N1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE2NzIwMzMsImV4cCI6MjA1NzI0ODAzM30.v7E8MvCGqmJKp-1kTnq2snKrpwMnFe9jDk2s4nwgQPs';

  /// OAuth Client IDs for Google Sign-In
  static const String webClientId =
      '379556665825-drnvt34ip30m685h8likcj3jnv2va4cd.apps.googleusercontent.com';
  static const String iosClientId =
      '379556665825-pe7kbstc2f1dnnpdm1snboqddr01r0d0.apps.googleusercontent.com';
}
