# == Schema Information
#
# Table name: discographies
#
#  id                          :uuid             not null, primary key
#  apple_music_collection_name :string           default(""), not null
#  artist_name                 :string           not null
#  artist_view_url             :string           not null
#  artwork_url100              :string           not null
#  artwork_url60               :string           not null
#  collection_censored_name    :string           not null
#  collection_explicitness     :string           not null
#  collection_name             :string           not null
#  collection_price            :integer
#  collection_type             :string           not null
#  collection_view_url         :text             not null
#  copyright                   :string           not null
#  country                     :string           not null
#  currency                    :string           not null
#  is_touhou                   :boolean          default(TRUE), not null
#  last_fetched_at             :datetime
#  primary_genre_name          :string           not null
#  record_label                :string           default(""), not null
#  release_date                :datetime         not null
#  spotify_collection_name     :string           default(""), not null
#  spotify_collection_view_url :string           default(""), not null
#  track_count                 :integer          not null
#  wrapper_type                :string           not null
#  youtube_collection_name     :string           default(""), not null
#  youtube_collection_view_url :string           default(""), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  apple_artist_id             :bigint           not null
#  apple_collection_id         :bigint           not null
#
# Indexes
#
#  index_discographies_on_apple_artist_id      (apple_artist_id)
#  index_discographies_on_apple_collection_id  (apple_collection_id) UNIQUE
#
class Discography < ApplicationRecord
  has_many :discographies_circles, dependent: :destroy
  has_many :circles, through: :discographies_circles
  has_many :songs, -> { order(Arel.sql('songs.track_number ASC')) }, dependent: :destroy

  scope :includes_songs, -> { includes(:songs) }
  scope :streamable, -> { includes_songs.where(songs: { is_streamable: true }) }
  scope :not_streamable, -> { includes_songs.where(songs: { is_streamable: false }) }

  scope :touhou_doujin, -> { where(record_label: '東方同人音楽流通') }
  scope :touhou, -> { where(is_touhou: true) }
  scope :not_touhou, -> { where(is_touhou: false) }
  scope :various_artists, -> { where(artist_name: "Various Artists") }
end
