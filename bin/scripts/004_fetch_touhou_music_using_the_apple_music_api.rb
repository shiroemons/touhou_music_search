#
# Apple Music APIを用いて、iTunes APIで取得出来ない情報を保存
#
# 使い方:
# $ bin/rails r bin/scripts/004_fetch_touhou_music_using_the_apple_music_api.rb
#

def correct_touhou_music(discography)
  url = "https://api.music.apple.com/v1/catalog/jp/albums/#{discography.apple_collection_id}"
  response = Faraday.get(url, nil, @headers)
  if response
    response_data = JSON.parse(response.body)

    collection_name = response_data.dig("data", 0, "attributes", "name")
    if collection_name
      discography.update(apple_music_collection_name: collection_name)
    end
    record_label = response_data.dig("data", 0, "attributes", "recordLabel")
    tracks_data = response_data.dig("data", 0, "relationships", "tracks", "data")
    if record_label != nil && record_label != ""
      discography.update(record_label: record_label)
    end

    is_touhou = discography.is_touhou && record_label == "東方同人音楽流通"
    unless is_touhou
      discography.update(is_touhou: false)
    end

    discography.songs.each do |song|
      track = tracks_data&.find { |t| song.apple_track_id.to_s == t["id"] }

      has_lyrics = track&.dig("attributes", "hasLyrics")
      if has_lyrics.present?
        song.update(has_lyrics: has_lyrics)
      end

      composer_name = track&.dig("attributes", "composerName")
      if composer_name.present?
        song.update(composer_name: composer_name)
      end

      if !song.is_touhou && Song.exceptional_touhou_songs.include?(song.apple_track_id)
        song.update(is_touhou: true)
      elsif song.is_touhou && !(is_touhou || (composer_name&.include?('ZUN') || composer_name&.include?('あきやまうに')))
        song.update(is_touhou: false)
      end
    end

    if discography.is_touhou && discography.songs.each.all? { |song| !song.is_touhou }
      discography.update(is_touhou: false)
    end

    discography.update(last_fetched_at: Time.zone.now)
  end
end

@headers = { "Authorization" => "Bearer #{AppleMusic::Token.token}" }
album_count = 0
discographies = Discography.order(updated_at: :desc)
max_albums = discographies.count
twelve_hours_ago = Time.zone.now.ago(12.hours)
discographies.find_each do |discography|
  if discography.last_fetched_at.nil? || twelve_hours_ago > discography.last_fetched_at
    correct_touhou_music(discography)
  end
  album_count += 1
  print "\rアルバム: #{album_count}/#{max_albums} Progress: #{(album_count * 100.0 / max_albums).round(1)}%"
  sleep 0.5
end