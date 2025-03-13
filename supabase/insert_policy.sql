-- Allow users to insert only their own words
create policy "User can insert own words" on favorite_words
  for insert
  with check (auth.uid() = user_id);