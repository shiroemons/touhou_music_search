# == Schema Information
#
# Table name: originals
#
#  code          :string           not null, primary key
#  original_type :string           not null
#  series_order  :float            not null
#  short_title   :string           not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Original < ApplicationRecord
  self.primary_key = :code

  enum original_type: {
    pc98: 'pc98',
    windows: 'windows',
    zuns_music_collection: 'zuns_music_collection',
    akyus_untouched_score: 'akyus_untouched_score',
    commercial_books: 'commercial_books',
    other: 'other',
  }

  has_many :original_songs, -> { order(Arel.sql('original_songs.track_number ASC')) },
           foreign_key: :original_code,
           inverse_of: :original,
           dependent: :destroy

  scope :original_song_non_duplicated, -> { includes(:original_songs).where(original_songs: { is_duplicate: false}) }
end
