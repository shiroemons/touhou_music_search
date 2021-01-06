module AppleMusic
  class InsertDiscography
    attr_reader :artist_id

    def initialize(artist_id)
      @artist_id = artist_id
    end

    def execute
      response = fetch_discography
      insert_discographies(response) if response.present?
    end

    def fetch_discography
      return if Discography.exists?(apple_artist_id: artist_id)

      # ref: https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
      url = "https://itunes.apple.com/lookup?id=#{artist_id}&entity=album&country=jp&lang=ja_jp"
      response = Faraday.get(url)
      response = JSON.parse(response.body)
      response
    end

    def insert_discographies(response)
      AppleMusic::InsertDiscography.insert_discographies(response)
    end

    class << self
      def insert_discographies(response)
        insert_data = []
        now = Time.now
        return if response["resultCount"].to_i <= 1
        response["results"].each do |result|
          wrapper_type = result["wrapperType"]
          apple_artist_id = result["artistId"]
          apple_collection_id = result["collectionId"]
          next if wrapper_type != "collection"
          unless Discography.exists?(apple_artist_id: apple_collection_id)
            insert_data << {
              wrapper_type: wrapper_type,
              collection_type: result["collectionType"],
              apple_artist_id: apple_artist_id,
              apple_collection_id: result["collectionId"],
              artist_name: result["artistName"],
              collection_name: result["collectionName"],
              collection_censored_name: result["collectionCensoredName"],
              artist_view_url: result["artistViewUrl"] || "",
              collection_view_url: result["collectionViewUrl"],
              artwork_url60: result["artworkUrl60"],
              artwork_url100: result["artworkUrl100"],
              collection_price: result["collectionPrice"],
              collection_explicitness: result["collectionExplicitness"],
              track_count: result["trackCount"],
              copyright: result["copyright"] || "",
              country: result["country"],
              currency: result["currency"],
              release_date: Time.parse(result["releaseDate"]),
              primary_genre_name: result["primaryGenreName"],
              created_at: now,
              updated_at: now
            }
          end
        end
        if insert_data.present?
          Discography.insert_all(insert_data)
        else
          puts "Empty album."
        end
      end
    end
  end
end
