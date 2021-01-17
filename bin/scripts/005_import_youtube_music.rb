#
# YouTube Musicの情報をSongに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/005_import_youtube_music.rb
#
require 'csv'

song_count = 0
touhou_songs = CSV.table('db/fixtures/touhou_music_with_youtube.tsv', col_sep: "\t", converters: nil, liberal_parsing: true)
max_songs = touhou_songs.count
touhou_songs.each do |ts|
  apple_track_view_url = ts[:apple_track_view_url]
  song = Song.find_by(track_view_url: apple_track_view_url)
  if song.present?
    youtube_collection_name = ts[:youtube_collection_name]
    youtube_track_name = ts[:youtube_track_name]
    youtube_collection_view_url = ts[:youtube_collection_view_url]
    youtube_track_view_url = ts[:youtube_track_view_url]
    song.update(
      youtube_collection_name: youtube_collection_name,
      youtube_track_name: youtube_track_name,
      youtube_collection_view_url: youtube_collection_view_url,
      youtube_track_view_url: youtube_track_view_url
    )
  end
  song_count += 1
  print "\r楽曲: #{song_count}/#{max_songs} Progress: #{(song_count * 100.0 / max_songs).round(1)}%"
end