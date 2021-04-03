module Types
  class OriginalType < Types::BaseObject
    field :code, String, null: false
    field :title, String, null: false
    field :short_title, String, null: false
    field :original_type, String, null: false
    field :series_order, Float, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
