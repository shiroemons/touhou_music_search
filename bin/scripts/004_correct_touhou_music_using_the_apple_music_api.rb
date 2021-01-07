#
# Apple Music APIを用いて、東方同人音楽流通経由のアルバムか確認し、is_touhouを変更する
#
# 使い方:
# $ bin/rails r bin/scripts/004_correct_touhou_music_using_the_apple_music_api.rb
#

def correct_touhou_music(discography)
  url = "https://api.music.apple.com/v1/catalog/jp/albums/#{discography.apple_collection_id}"
  response = Faraday.get(url, nil, @headers)
  if response
    response_data = JSON.parse(response.body)

    record_label = response_data.dig("data", 0, "attributes", "recordLabel")
    if record_label != nil && record_label != ""
      if record_label != "東方同人音楽流通"
        discography.update(is_touhou: false)
        discography.songs.each do |song|
          song.update(is_touhou: false) if song.is_touhou
        end
      end
    else
      puts "ID: #{discography.apple_collection_id}"
    end
  end
end

@headers = { "Authorization" => "Bearer #{AppleMusic::Token.token}" }
album_count = 0
max_albums = Discography.touhou.count
Discography.touhou.find_each do |discography|
  correct_touhou_music(discography)
  album_count += 1
  print "\rアルバム: #{album_count}/#{max_albums} Progress: #{(album_count * 100.0 / max_albums).round(1)}%"
  sleep 0.5
end