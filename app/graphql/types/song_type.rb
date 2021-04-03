module Types
  class SongType < Types::BaseObject
    field :id, ID, null: false
    field :discography, Types::DiscographyType, null: false
    field :wrapper_type, String, null: false
    field :kind, String, null: false
    field :apple_artist_id, Integer, null: false
    field :apple_collection_id, Integer, null: false
    field :apple_track_id, Integer, null: false
    field :artist_name, String, null: false
    field :collection_name, String, null: false
    field :track_name, String, null: false
    field :collection_censored_name, String, null: false
    field :track_censored_name, String, null: false
    field :artist_view_url, String, null: false
    field :collection_view_url, String, null: false
    field :track_view_url, String, null: false
    field :preview_url, String, null: false
    field :artwork_url30, String, null: false
    field :artwork_url60, String, null: false
    field :artwork_url100, String, null: false
    field :collection_price, Integer, null: true
    field :track_price, Integer, null: true
    field :release_date, GraphQL::Types::ISO8601DateTime, null: false
    field :collection_explicitness, String, null: false
    field :track_explicitness, String, null: false
    field :disc_count, Integer, null: false
    field :disc_number, Integer, null: false
    field :track_count, Integer, null: false
    field :track_number, Integer, null: false
    field :track_time_millis, Integer, null: false
    field :country, String, null: false
    field :currency, String, null: false
    field :primary_genre_name, String, null: false
    field :is_streamable, Boolean, null: false
    field :is_touhou, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :composer_name, String, null: false
    field :has_lyrics, Boolean, null: false
    field :youtube_collection_name, String, null: false
    field :youtube_track_name, String, null: false
    field :youtube_collection_view_url, String, null: false
    field :youtube_track_view_url, String, null: false
    field :original_songs, [Types::OriginalSongType], null: true
  end
end
