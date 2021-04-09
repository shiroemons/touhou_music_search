#
# Songに原曲情報を紐付ける
#
# 使い方:
# $ bin/rails r bin/scripts/006_associate_original_song_with_song
#
require 'csv'

URL = 'https://raw.githubusercontent.com/shiroemons/touhou_streaming_with_original_songs/main/touhou_music_with_original_songs.tsv'.freeze

token = ENV['GITHUB_TOKEN']
if token.present?
  headers = { 'Authorization' => "token #{token}" }
  response = Faraday.get(URL, nil, headers)
  songs = CSV.new(response.body, col_sep: "\t", converters: nil, liberal_parsing: true, encoding: 'UTF-8', headers: true)
  songs = songs.read
  songs.inspect

  max_songs = songs.size
  songs.each.with_index(1) do |track, song_count|
    original_songs = track[:original_songs]
    apple_track_id = track[:apple_track_id]
    song = Song.find_by(apple_track_id: apple_track_id)
    if song && original_songs
      original_song_list = OriginalSong.where(title: original_songs.split('/'), is_duplicate: false)
      song.original_songs = original_song_list
    end
    print "\r東方楽曲: #{song_count}/#{max_songs} Progress: #{(song_count * 100.0 / max_songs).round(1)}%"
  end
else
  puts 'GITHUB_TOKEN を設定してください。'
end
