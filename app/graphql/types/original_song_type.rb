module Types
  class OriginalSongType < Types::BaseObject
    field :code, String, null: false
    field :original, Types::OriginalType, null: false
    field :title, String, null: false
    field :composer, String, null: false
    field :track_number, Integer, null: false
    field :is_duplicate, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
