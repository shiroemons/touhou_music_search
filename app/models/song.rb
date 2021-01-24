class Song < ApplicationRecord
  belongs_to :discography

  scope :includes_discography, -> { includes(:discography) }
  scope :touhou_doujin, -> { includes_discography.where(discographies: { record_label: '東方同人音楽流通' }) }

  scope :touhou, -> { where(is_touhou: true) }
  scope :not_touhou, -> { where(is_touhou: false) }
  scope :streamable, -> { where(is_streamable: true)}
  scope :not_streamable, -> { where(is_streamable: false)}
  scope :has_lyrics, -> { where(has_lyrics: true) }
  scope :has_not_lyrics, -> { where(has_lyrics: false) }
  scope :youtube_music, -> { where.not(youtube_track_name: '') }
end
