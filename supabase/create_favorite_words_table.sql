-- Create the favorite_words table
create table favorite_words (
  id uuid primary key default uuid_generate_v4(),
  word text not null,
  user_id uuid not null
);