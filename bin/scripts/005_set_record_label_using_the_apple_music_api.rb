
def set_record_label(discography)
  url = "https://api.music.apple.com/v1/catalog/jp/albums/#{discography.apple_collection_id}"
  response = Faraday.get(url, nil, @headers)
  if response
    response_data = JSON.parse(response.body)

    record_label = response_data.dig("data", 0, "attributes", "recordLabel")
    if record_label != nil && record_label != ""
      discography.update(record_label: record_label)
    else
      puts "ID: #{discography.apple_collection_id}"
    end
  end
end

@headers = { "Authorization" => "Bearer #{AppleMusic::Token.token}" }
album_count = 0
max_albums = Discography.count
Discography.find_each do |discography|
  set_record_label(discography)
  album_count += 1
  print "\rアルバム: #{album_count}/#{max_albums} Progress: #{(album_count * 100.0 / max_albums).round(1)}%"
  sleep 0.5
end