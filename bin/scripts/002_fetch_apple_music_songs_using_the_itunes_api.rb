#
# iTunes APIを用いて、アルバムに紐づくトラック情報を取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/002_fetch_apple_music_songs_using_the_itunes_api.rb
#

def fetch_songs(id)
  return if Song.exists?(apple_collection_id: id)
  url = "https://itunes.apple.com/lookup?id=#{id}&entity=song&country=jp&lang=ja_jp"
  response = Faraday.get(url)
  response = JSON.parse(response.body)
  response
end

def insert_songs(response, id)
  discography = Discography.find_by(apple_collection_id: id)
  if discography.nil?
    insert_discographies(response, id)
    discography = Discography.find_by(apple_collection_id: id)
  end
  return if response["resultCount"].to_i <= 1
  insert_data = []
  now = Time.now
  response["results"].each do |result|
    wrapper_type = result["wrapperType"]
    apple_collection_id = result["collectionId"]
    next if id != apple_collection_id
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
      artist_view_url: result["artistViewUrl"],
      collection_view_url: result["collectionViewUrl"],
      track_view_url: result["trackViewUrl"],
      preview_url: result["previewUrl"],
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

def insert_discographies(response, id)
  insert_data = []
  now = Time.now
  return if response["resultCount"].to_i <= 1
  response["results"].each do |result|
    wrapper_type = result["wrapperType"]
    apple_artist_id = result["artistId"]
    next if wrapper_type != "collection"
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
    puts "Empty collection."
  end
end

Discography.touhou.find_each do |d|
  id = d.apple_collection_id
  puts "#{d.collection_name}(#{id})"
  response = fetch_songs(id)
  if response.present?
    insert_songs(response, id)
  end
  sleep 0.5
end