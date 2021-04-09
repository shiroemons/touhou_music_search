module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :originals, [Types::OriginalType], null: true
    def originals
      Original.original_song_non_duplicated.order(:code)
    end

    field :discographies, Types::DiscographyType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end
    def discographies(page: nil, limit: nil)
      Discography.includes_songs.touhou_doujin.touhou.order(release_date: :desc).page(page).per(limit)
    end

    field :songs, Types::SongType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
      argument :original_song_title, String, required: false
    end
    def songs(page: nil, limit: nil, original_song_title: nil)
      if original_song_title
        Song.touhou_music
            .where(original_songs: { title: original_song_title })
            .page(page).per(limit)
      else
        Song.touhou_music.page(page).per(limit)
      end
    end
  end
end
