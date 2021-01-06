#
# iTunes APIを用いて、アーティストに紐づくアルバムを取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/001_fetch_apple_music_albums_using_the_itunes_api.rb
#

def fetch_discography(id)
  return if Discography.exists?(apple_artist_id: id)

  # ref: https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
  url = "https://itunes.apple.com/lookup?id=#{id}&entity=album&country=jp&lang=ja_jp"
  response = Faraday.get(url)
  response = JSON.parse(response.body)
  response
end

def insert_discographies(response, id)
  insert_data = []
  now = Time.now
  return if response["resultCount"].to_i <= 1
  response["results"].each do |result|
    wrapper_type = result["wrapperType"]
    apple_artist_id = result["artistId"]
    next if id != apple_artist_id
    next if wrapper_type != "collection"
    insert_data << {
      wrapper_type: wrapper_type,
      collection_type: result["collectionType"],
      apple_artist_id: apple_artist_id,
      apple_collection_id: result["collectionId"],
      artist_name: result["artistName"],
      collection_name: result["collectionName"],
      collection_censored_name: result["collectionCensoredName"],
      artist_view_url: result["artistViewUrl"],
      collection_view_url: result["collectionViewUrl"],
      artwork_url60: result["artworkUrl60"],
      artwork_url100: result["artworkUrl100"],
      collection_price: result["collectionPrice"],
      collection_explicitness: result["collectionExplicitness"],
      track_count: result["trackCount"],
      copyright: result["copyright"],
      country: result["country"],
      currency: result["currency"],
      release_date: Time.parse(result["releaseDate"]),
      primary_genre_name: result["primaryGenreName"],
      created_at: now,
      updated_at: now
    }
  end
  if insert_data.present?
    Discography.insert_all(insert_data)
  else
    puts "Empty album. apple_artist_id: #{id}"
  end
end

MasterArtist.all.each do |ma|
  id = ma.apple_artist_id
  response = fetch_discography(id)
  if response.present?
    insert_discographies(response, id)
  end
  sleep 0.5
end