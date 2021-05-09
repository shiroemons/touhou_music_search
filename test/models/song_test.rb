# == Schema Information
#
# Table name: songs
#
#  id                          :uuid             not null, primary key
#  artist_name                 :string           not null
#  artist_view_url             :string           default(""), not null
#  artwork_url100              :string           not null
#  artwork_url30               :string           not null
#  artwork_url60               :string           not null
#  collection_censored_name    :string           not null
#  collection_explicitness     :string           not null
#  collection_name             :string           not null
#  collection_price            :integer
#  collection_view_url         :text             not null
#  composer_name               :string           default(""), not null
#  country                     :string           not null
#  currency                    :string           not null
#  disc_count                  :integer          not null
#  disc_number                 :integer          not null
#  has_lyrics                  :boolean          default(FALSE), not null
#  is_streamable               :boolean          default(FALSE), not null
#  is_touhou                   :boolean          default(TRUE), not null
#  kind                        :string           not null
#  preview_url                 :string           default(""), not null
#  primary_genre_name          :string           not null
#  release_date                :datetime         not null
#  spotify_collection_name     :string           default(""), not null
#  spotify_collection_view_url :string           default(""), not null
#  spotify_track_name          :string           default(""), not null
#  spotify_track_view_url      :string           default(""), not null
#  track_censored_name         :string           not null
#  track_count                 :integer          not null
#  track_explicitness          :string           not null
#  track_name                  :string           not null
#  track_number                :integer          not null
#  track_price                 :integer
#  track_time_millis           :integer          not null
#  track_view_url              :text             not null
#  wrapper_type                :string           not null
#  youtube_collection_name     :string           default(""), not null
#  youtube_collection_view_url :string           default(""), not null
#  youtube_track_name          :string           default(""), not null
#  youtube_track_view_url      :string           default(""), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  apple_artist_id             :bigint           not null
#  apple_collection_id         :bigint           not null
#  apple_track_id              :bigint           not null
#  discography_id              :uuid             not null
#
# Indexes
#
#  index_songs_on_apple_artist_id      (apple_artist_id)
#  index_songs_on_apple_collection_id  (apple_collection_id)
#  index_songs_on_apple_track_id       (apple_track_id) UNIQUE
#  index_songs_on_discography_id       (discography_id)
#
# Foreign Keys
#
#  fk_rails_...  (discography_id => discographies.id)
#
require "test_helper"

class SongTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
