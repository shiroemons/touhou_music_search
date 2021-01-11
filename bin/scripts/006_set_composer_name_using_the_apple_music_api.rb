
def set_composer_name(discography)
  url = "https://api.music.apple.com/v1/catalog/jp/albums/#{discography.apple_collection_id}"
  response = Faraday.get(url, nil, @headers)
  if response
    response_data = JSON.parse(response.body)

    tracks_data = response_data.dig("data", 0, "relationships", "tracks", "data")
    discography.songs.each do |song|
      track = tracks_data&.find { |t| song.apple_track_id.to_s == t["id"] }
      composer_name = track&.dig("attributes", "composerName")
      if composer_name.present?
        song.update(composer_name: composer_name)
      end
    end
  end
end

@headers = { "Authorization" => "Bearer #{AppleMusic::Token.token}" }
album_count = 0
max_albums = Discography.count
Discography.find_each do |discography|
  set_composer_name(discography)
  album_count += 1
  print "\rアルバム: #{album_count}/#{max_albums} Progress: #{(album_count * 100.0 / max_albums).round(1)}%"
  sleep 0.5
end