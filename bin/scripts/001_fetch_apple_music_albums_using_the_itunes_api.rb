#
# iTunes APIを用いて、アーティストに紐づくアルバムを取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/001_fetch_apple_music_albums_using_the_itunes_api.rb
#

MasterArtist.all.each do |ma|
  id = ma.apple_artist_id
  AppleMusic::InsertDiscography.new(id).execute
  sleep 0.5
end