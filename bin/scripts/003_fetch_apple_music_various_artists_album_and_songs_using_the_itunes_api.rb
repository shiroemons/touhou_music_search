#
# iTunes APIを用いて、アーティストに紐づくVarious Artistsのアルバムとトラック情報を取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/003_fetch_apple_music_various_artists_album_and_songs_using_the_itunes_api.rb
#

artist_count = 0
artists = Song.touhou.pluck(:apple_artist_id).uniq
max_artists = artists.count
artists.each do |id|
  url = "https://itunes.apple.com/lookup?id=#{id}&entity=song&country=jp&lang=ja_jp&limit=200"
  response = Faraday.get(url)
  response = JSON.parse(response.body)
  response["results"].each do |result|
    wrapper_type = result["wrapperType"]
    collection_name = result["collectionName"]
    collection_id = result["collectionId"]
    collection_artist_name = result["collectionArtistName"]
    next if wrapper_type != "track"
    if collection_artist_name == "Various Artists"
      discography = Discography.find_by(apple_collection_id: collection_id)
      if discography.nil?
        AppleMusic::InsertSong.new(collection_id).execute
        sleep 0.5
      end
    end
  end
  artist_count += 1
  print "\rアーティスト: #{artist_count}/#{max_artists} Progress: #{(artist_count * 100.0 / max_artists).round(1)}%"
end

