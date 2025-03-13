-- Allow users to select only their own words
create policy "User can select own words" on favorite_words
  for select
  using (auth.uid() = user_id);