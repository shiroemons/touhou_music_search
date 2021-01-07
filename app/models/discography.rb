class Discography < ApplicationRecord
  has_many :songs, -> { order(Arel.sql('songs.track_number ASC')) }, dependent: :destroy

  scope :touhou, -> { where(is_touhou: true) }
  scope :not_touhou, -> { where(is_touhou: false) }
  scope :various_artists, -> { where(artist_name: "Various Artists") }
end
