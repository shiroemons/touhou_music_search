module Types
  class DiscographyType < Types::BaseObject
    field :id, ID, null: false
    field :wrapper_type, String, null: false
    field :collection_type, String, null: false
    field :apple_artist_id, GraphQL::Types::BigInt, null: false
    field :apple_collection_id, GraphQL::Types::BigInt, null: false
    field :artist_name, String, null: false
    field :collection_name, String, null: false
    field :collection_censored_name, String, null: false
    field :artist_view_url, String, null: false
    field :collection_view_url, String, null: false
    field :artwork_url60, String, null: false
    field :artwork_url100, String, null: false
    field :collection_price, Integer, null: true
    field :collection_explicitness, String, null: false
    field :track_count, Integer, null: false
    field :copyright, String, null: false
    field :country, String, null: false
    field :currency, String, null: false
    field :release_date, GraphQL::Types::ISO8601DateTime, null: false
    field :primary_genre_name, String, null: false
    field :is_touhou, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :record_label, String, null: false
    field :apple_music_collection_name, String, null: false
    field :youtube_collection_name, String, null: false
    field :youtube_collection_view_url, String, null: false
  end
end
