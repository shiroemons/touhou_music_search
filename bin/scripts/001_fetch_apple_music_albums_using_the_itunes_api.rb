#
# iTunes APIを用いて、アーティストに紐づくアルバムを取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/001_fetch_apple_music_albums_using_the_itunes_api.rb
#

master_artist_count = 0
max_master_artists = MasterArtist.apple_music.count
MasterArtist.apple_music.each do |ma|
  id = ma.key
  AppleMusic::InsertDiscography.new(id).execute
  master_artist_count += 1
  print "\rマスターアーティスト: #{master_artist_count}/#{max_master_artists} Progress: #{(master_artist_count * 100.0 / max_master_artists).round(1)}%"
  sleep 0.5
end