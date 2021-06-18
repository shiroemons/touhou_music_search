#
# Odesli APIを用いて、アルバムを取得し、DBに保存する
#
# 使い方:
# $ bin/rails r bin/scripts/008_fetch_odesli_album.rb
#

MAX_RETRY_COUNT = 3
album_count = 0
max_albums = Discography.touhou.count

Discography.touhou.find_each do |d|
  if d.odesli_album.blank?
    odesli = Odesli.new(d.collection_view_url)
    if odesli.status == 200
      d.create_odesli_album!(payload: odesli.body, fetched_at: Time.zone.now)
      amazon_music_title = odesli.amazon_music_title
      amazon_music_url = odesli.amazon_music_url
      amazon_store_url = odesli.amazon_store_url
      if amazon_music_title && amazon_music_url && amazon_store_url
        d.update!(
          amazon_music_collection_name: amazon_music_title,
          amazon_music_collection_view_url: amazon_music_url,
          amazon_store_collection_view_url: amazon_store_url
        )
      end
    end
    sleep(8)
  end

  album_count += 1
  print "\rアルバム: #{album_count}/#{max_albums} Progress: #{(album_count * 100.0 / max_albums).round(1)}%"
end
