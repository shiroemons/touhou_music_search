module AppleMusic
  class InsertSong
    attr_reader :collection_id

    def initialize(collection_id)
      @collection_id = collection_id
    end

    def execute
      response = fetch_songs
      insert_songs(response) if response.present?
    end

    def fetch_songs
      return if Song.exists?(apple_collection_id: collection_id)
      url = "https://itunes.apple.com/lookup?id=#{collection_id}&entity=song&country=jp&lang=ja_jp&limit=200"
      response = Faraday.get(url)
      response = JSON.parse(response.body)
      response
    end

    def insert_songs(response)
      discography = Discography.find_by(apple_collection_id: collection_id)
      if discography.nil?
        AppleMusic::InsertDiscography.insert_discographies(response)
        discography = Discography.find_by(apple_collection_id: collection_id)
        return if discography.nil?
      end
      return if response["resultCount"].to_i <= 1
      insert_data = []
      now = Time.now
      response["results"].each do |result|
        wrapper_type = result["wrapperType"]
        apple_collection_id = result["collectionId"]
        next if collection_id != apple_collection_id
        next if wrapper_type != "track"
        insert_data << {
          discography_id: discography.id,
          wrapper_type: wrapper_type,
          kind: result["kind"],
          apple_artist_id: result["artistId"],
          apple_collection_id: apple_collection_id,
          apple_track_id: result["trackId"],
          artist_name: result["artistName"],
          collection_name: result["collectionName"],
          track_name: result["trackName"],
          collection_censored_name: result["collectionCensoredName"],
          track_censored_name: result["trackCensoredName"],
          artist_view_url: result["artistViewUrl"] || "",
          collection_view_url: result["collectionViewUrl"],
          track_view_url: result["trackViewUrl"],
          preview_url: result["previewUrl"] || "",
          artwork_url30: result["artworkUrl30"],
          artwork_url60: result["artworkUrl60"],
          artwork_url100: result["artworkUrl100"],
          collection_price: result["collectionPrice"],
          track_price: result["trackPrice"],
          release_date: Time.parse(result["releaseDate"]),
          collection_explicitness: result["collectionExplicitness"],
          track_explicitness: result["trackExplicitness"],
          disc_count: result["discCount"],
          disc_number: result["discNumber"],
          track_count: result["trackCount"],
          track_number: result["trackNumber"],
          track_time_millis: result["trackTimeMillis"],
          country: result["country"],
          currency: result["currency"],
          primary_genre_name: result["primaryGenreName"],
          is_streamable: result["isStreamable"],
          created_at: now,
          updated_at: now
        }
      end
      if insert_data.present?
        Song.insert_all(insert_data)
      else
        puts "Empty collection: #{apple_collection_id}"
      end
    end
  end
end
