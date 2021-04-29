# == Schema Information
#
# Table name: songs_original_songs
#
#  id                 :uuid             not null, primary key
#  original_song_code :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  song_id            :uuid             not null
#
# Indexes
#
#  index_songs_original_songs_on_original_song_code  (original_song_code)
#  index_songs_original_songs_on_song_id             (song_id)
#
# Foreign Keys
#
#  fk_rails_...  (song_id => songs.id)
#
class SongsOriginalSong < ApplicationRecord
  belongs_to :original_song, foreign_key: :original_song_code, primary_key: :code
  belongs_to :song
end
