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
require "test_helper"

class DiscographyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
