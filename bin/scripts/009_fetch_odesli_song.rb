#
# Odesli APIを用いて、楽曲を取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/009_fetch_odesli_song.rb
#

song_count = 0
max_songs = Song.joins(:discography).where('"discographies"."is_touhou" = true').count

Discography.touhou.find_each do |d|
  if d.odesli_album.present? && d.amazon_music_collection_name.present?
    d.songs.find_each do |song|
      if song.odesli_song.blank?
        odesli = Odesli.new(song.track_view_url)
        if odesli.status == 200
          song.create_odesli_song!(payload: odesli.body, fetched_at: Time.zone.now)
          amazon_music_title = odesli.amazon_music_title
          amazon_music_url = odesli.amazon_music_url
          if amazon_music_title && amazon_music_url
            song.update!(
              amazon_music_collection_name: d.amazon_music_collection_name,
              amazon_music_track_name: amazon_music_title,
              amazon_music_collection_view_url: d.amazon_music_collection_view_url,
              amazon_store_collection_view_url: d.amazon_store_collection_view_url,
              amazon_music_track_view_url: amazon_music_url
            )
          end
        end
        sleep(8)
      end
      song_count += 1
      print "\r楽曲: #{song_count}/#{max_songs} Progress: #{(song_count * 100.0 / max_songs).round(1)}%"
    end
  else
    song_count += d.songs.size
  end
  print "\r楽曲: #{song_count}/#{max_songs} Progress: #{(song_count * 100.0 / max_songs).round(1)}%"
end
