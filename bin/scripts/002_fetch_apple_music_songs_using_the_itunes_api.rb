#
# iTunes APIを用いて、アルバムに紐づくトラック情報を取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/002_fetch_apple_music_songs_using_the_itunes_api.rb
#

album_count = 0
max_albums = Discography.touhou.count
Discography.touhou.find_each do |d|
  collection_id = d.apple_collection_id
  unless Song.exists?(apple_collection_id: collection_id)
    AppleMusic::InsertSong.new(collection_id).execute
    sleep 0.5
  end
  album_count += 1
  print "\rアルバム: #{album_count}/#{max_albums} Progress: #{(album_count * 100.0 / max_albums).round(1)}%"
end