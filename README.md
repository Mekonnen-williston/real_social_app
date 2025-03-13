# RealSocial Flutter App

A Flutter application that demonstrates clean architecture, real-time updates with Supabase, state management with Riverpod, and navigation with AutoRoute. The app allows users to log in using Google Sign-In and manage their list of favorite words in real time. It also uses an AnimatedList to provide smooth UI animations when words are added.

## Features

- **Authentication:**  
  - Google Sign-In using the [google_sign_in](https://pub.dev/packages/google_sign_in) package.
  - Supabase authentication with real-time session management.
  
- **Real-Time Data:**  
  - Favorite words are stored in Supabase.
  - The app listens to real-time changes to update the UI automatically.

- **State Management:**  
  - Uses Riverpod to manage application state, including a local provider for favorite words.

- **Navigation:**  
  - AutoRoute (with AdaptiveAutoRouter) for type-safe, declarative navigation.
  - A splash screen that redirects based on the current authentication state.

- **Animated List:**  
  - Uses an AnimatedList widget to animate the addition of words.

- **User Experience Enhancements:**  
  - A toast notification is displayed when a milestone count of favorite words is reached (e.g., 5, 12, 17, 21, or 25 words).

## Project Structure

```
lib/
├── core/
│   ├── router/
│   │   ├── app_route.dart
│   │   ├── app_route.gr.dart
│   │   ├── auth_guard.dart
│   ├── api_keys.dart
│   ├── app_strings.dart
│   ├── assets/
│   ├── database_constants.dart
│   ├── mixins.dart
├── data/
│   ├── supabase_service.dart
│   └── repositories/
│       ├── auth_repository_impl.dart
│       └── word_repository_impl.dart
├── models/
│   ├── extensions/
│   │   ├── word_extension.dart
│   └── word.dart
├── presentation/
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── word_list_provider.dart
│   ├── screens/
│   │   ├── home/
│   │   ├── home_screen.dart
│   │   ├── widgets/
│   │   │   ├── add_new_word_widget.dart
│   │   │   ├── animated_word_list_widget.dart
│   │   │   ├── empty_word_widget.dart
│   │   │   └── word_body_widget.dart
│   │   │   └── word_card_widget.dart
│   │   ├── login/
│   │   ├── widgets/
│   │   │   ├── google_sign_in_widget.dart
│   │   ├── login_screen.dart
│   │   ├── splash_screen.dart
│   └── widgets/
│   │   │   ├── loading_widget.dart
│   |   |   ├── toast_widget.dart
│   |   |   ├── loading_widget.dart
│   |   |   └── retry_widget.dart
└── main.dart
Supabase/
├── create_favorite_words_table.sql
├── enable_rls.sql
├── select_policy.sql
├── insert_policy.sql
└── delete_policy.sql
```

## Supabase SQL Functions and Policies:

* The following SQL commands are used to set up the database schema and policies for the `favorite_words` table in Supabase. 

### They are also included under the `Supabase` directory in the project structure.

```sql
-- Create favorite_words table
create table favorite_words (
  id uuid primary key default uuid_generate_v4(),
  word text not null,
  user_id uuid not null
);

-- Enable row-level security
alter table favorite_words enable row level security;

-- Allow users to select only their own words
create policy "User can select own words" on favorite_words
  for select
  using (auth.uid() = user_id);

-- Allow users to insert only their own words
create policy "User can insert own words" on favorite_words
  for insert
  with check (auth.uid() = user_id);

-- Allow users to delete only their own words
create policy "User can delete own words" on favorite_words
  for delete
  using (auth.uid() = user_id);
```
