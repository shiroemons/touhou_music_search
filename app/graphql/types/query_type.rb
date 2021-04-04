module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :songs, Types::SongType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end
    def songs(page: nil, limit: nil)
      Song.includes(original_songs: :original)
            .touhou_doujin
            .order(release_date: :desc, track_number: :asc)
            .page(page).per(limit)
    end

    field :songs, Types::SongType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
      argument :original_song_title, String, required: true
    end
    def songs(page: nil, limit: nil, original_song_title: nil)
      Song.includes(original_songs: :original)
          .touhou_doujin
          .order(release_date: :desc, track_number: :asc)
          .where(original_songs: { title: original_song_title })
          .page(page).per(limit)
    end
  end
end
