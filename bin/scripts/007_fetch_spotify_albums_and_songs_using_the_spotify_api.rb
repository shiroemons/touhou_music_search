#
# Spotify APIを用いて、アーティストに紐づくアルバムと楽曲を取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/007_fetch_spotify_albums_and_songs_using_the_spotify_api.rb
#

master_artist_count = 0
max_master_artists = MasterArtist.spotify.count
File.open("tmp/touhou_music_spotify_all.tsv", "w") do |f|
  f.puts "artist_name\talbum_name"
end
MasterArtist.spotify.each do |ma|
  id = ma.key
  Spotify.fetch_albums_and_songs(id)
  master_artist_count += 1
  print "\rマスターアーティスト: #{master_artist_count}/#{max_master_artists} Progress: #{(master_artist_count * 100.0 / max_master_artists).round(1)}%"
  sleep 0.5
end