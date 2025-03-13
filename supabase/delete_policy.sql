-- Allow users to delete only their own words
create policy "User can delete own words" on favorite_words
  for delete
  using (auth.uid() = user_id);