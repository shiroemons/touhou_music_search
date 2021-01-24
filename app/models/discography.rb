class Discography < ApplicationRecord
  has_many :songs, -> { order(Arel.sql('songs.track_number ASC')) }, dependent: :destroy

  scope :includes_songs, -> { includes(:songs) }
  scope :streamable, -> { includes_songs.where(songs: { is_streamable: true }) }
  scope :not_streamable, -> { includes_songs.where(songs: { is_streamable: false }) }

  scope :touhou_doujin, -> { where(record_label: '東方同人音楽流通') }
  scope :touhou, -> { where(is_touhou: true) }
  scope :not_touhou, -> { where(is_touhou: false) }
  scope :various_artists, -> { where(artist_name: "Various Artists") }
end
