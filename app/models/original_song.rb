# == Schema Information
#
# Table name: original_songs
#
#  code          :string           not null, primary key
#  composer      :string           default(""), not null
#  is_duplicate  :boolean          default(FALSE), not null
#  original_code :string           not null
#  title         :string           not null
#  track_number  :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_original_songs_on_code           (code) UNIQUE
#  index_original_songs_on_original_code  (original_code)
#
class OriginalSong < ApplicationRecord
  self.primary_key = :code

  has_many :songs_original_songs, foreign_key: :original_song_code
  has_many :songs, through: :songs_original_songs

  belongs_to :original,
             foreign_key: :original_code,
             primary_key: :code,
             inverse_of: :original_songs

  scope :non_duplicated, -> { where(is_duplicate: false) }
end
