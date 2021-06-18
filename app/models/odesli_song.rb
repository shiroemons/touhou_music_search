# == Schema Information
#
# Table name: odesli_songs
#
#  id         :uuid             not null, primary key
#  fetched_at :datetime         not null
#  payload    :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  song_id    :uuid             not null
#
# Indexes
#
#  index_odesli_songs_on_song_id  (song_id)
#
# Foreign Keys
#
#  fk_rails_...  (song_id => songs.id)
#
class OdesliSong < ApplicationRecord
  belongs_to :song
end
