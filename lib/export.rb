File.open("tmp/touhou_music.tsv", "w") do |f|
  # f.puts("collection_name\ttrack_name\tartist_name\tcomposer_name\ttrack_number\trelease_date\tcollection_view_url\ttrack_view_url")
  f.puts("collection_name\ttrack_name\tartist_name\ttrack_number\trelease_date\tcollection_view_url\ttrack_view_url\tspotify_collection_name\tspotify_track_name\tspotify_collection_view_url\tspotify_track_view_url")
  Discography.includes(:songs).touhou_doujin.order(:release_date).each do |d|
    collection_view_url = d.collection_view_url
    id = d.apple_collection_id
    track_count = d.track_count
    song_count = d.songs.count
    if track_count != song_count
      puts "#{id}\t#{d.apple_music_collection_name}\t#{track_count}\t#{song_count}"
    end
    d.songs.each do |song|
      collection_name = song.collection_name
      track_name = song.track_name
      artist_name = song.artist_name
      composer_name = song.composer_name
      track_number = song.track_number
      release_date = song.release_date
      track_view_url = song.track_view_url
      spotify_collection_name = song.spotify_collection_name
      spotify_track_name = song.spotify_track_name
      spotify_collection_view_url = song.spotify_collection_view_url
      spotify_track_view_url = song.spotify_track_view_url
      # if song.is_streamable
      #   f.puts("#{collection_name}\t#{track_name}\t#{artist_name}\t#{composer_name}\t#{track_number}\t#{release_date}\t#{collection_view_url}\t#{track_view_url}")
      # end
      f.puts("#{collection_name}\t#{track_name}\t#{artist_name}\t#{track_number}\t#{release_date}\t#{collection_view_url}\t#{track_view_url}\t#{spotify_collection_name}\t#{spotify_track_name}\t#{spotify_collection_view_url}\t#{spotify_track_view_url}")
    end
  end
end

File.open("tmp/touhou_music_not_apple_music.tsv", "w") do |f|
  f.puts("collection_name\ttrack_name\tartist_name\tcomposer_name\ttrack_number\trelease_date\tcollection_view_url\ttrack_view_url")
  Discography.includes(:songs).touhou_doujin.touhou.order(:release_date).each do |d|
    collection_view_url = d.collection_view_url
    d.songs.each do |song|
      collection_name = song.collection_name
      track_name = song.track_name
      artist_name = song.artist_name
      composer_name = song.composer_name
      track_number = song.track_number
      release_date = song.release_date
      track_view_url = song.track_view_url
      if song.is_touhou && !song.is_streamable
        f.puts("#{collection_name}\t#{track_name}\t#{artist_name}\t#{composer_name}\t#{track_number}\t#{release_date}\t#{collection_view_url}\t#{track_view_url}")
      end
    end
  end
end

File.open("tmp/touhou_music_has_lyrics.tsv", "w") do |f|
  f.puts("collection_name\ttrack_name\tartist_name\ttrack_view_url")
  Discography.includes(:songs).touhou_doujin.touhou.order(:artist_name).each do |d|
    d.songs.each do |song|
      collection_name = song.collection_name
      track_name = song.track_name
      artist_name = song.artist_name
      track_view_url = song.track_view_url
      if song.is_touhou && song.is_streamable && song.has_lyrics
        f.puts("#{collection_name}\t#{track_name}\t#{artist_name}\t#{track_view_url}")
      end
    end
  end
end

File.open("tmp/touhou_music_albums.tsv", "w") do |f|
  f.puts("artist_name\tcollection_name\tcollection_view_url")
  Discography.includes(:songs).touhou_doujin.touhou.order(:artist_name).order(:apple_music_collection_name).each do |d|
    artist_name = d.artist_name
    collection_name = d.apple_music_collection_name
    collection_view_url = d.collection_view_url.gsub('?uo=4', '')
    f.puts("#{artist_name}\t#{collection_name}\t#{collection_view_url}")
  end
end

File.open("tmp/touhou_music_albums_with_songs.tsv", "w") do |f|
  f.puts("apple_collection_id\tcollection_name")
  Discography.includes(:songs).touhou_doujin.touhou.order(:apple_collection_id).each do |d|
    collection_name = d.collection_name
    d.songs.each do |song|
      track_name = song.track_name
      artist_name = song.artist_name
      composer_name = song.composer_name
      track_number = song.track_number
      f.puts("#{collection_name}\t#{track_name}\t#{artist_name}\t#{composer_name}\t#{track_number}")
    end
  end
end

apple_music_songs = []
Song.touhou_doujin.touhou.streamable.find_each do |song|
  track_name = song.track_name
  collection_name = song.collection_name
  track_view_url = song.track_view_url.gsub('&uo=4','')
  apple_music_songs.push({ title: track_name, collection_name: collection_name, url: track_view_url})
end

File.open("tmp/touhou_music_song_apple.json", "w") do |f|
  f.puts JSON.pretty_generate(apple_music_songs)
end

youtube_music_songs = []
Song.touhou_doujin.touhou.youtube_music.order(:collection_name).find_each do |song|
  track_name = song.youtube_track_name
  collection_name = song.youtube_collection_name
  track_view_url = song.youtube_track_view_url
  if track_name.present? && track_name != "不明"
    youtube_music_songs.push({ title: track_name, collection_name: collection_name, url: track_view_url})
  end
end

File.open("tmp/touhou_music_song_youtube.json", "w") do |f|
  f.puts JSON.pretty_generate(youtube_music_songs)
end

spotify_songs = []
Song.touhou_doujin.touhou.spotify.order(:collection_name).find_each do |song|
  track_name = song.spotify_track_name
  collection_name = song.spotify_collection_name
  track_view_url = song.spotify_track_view_url
  if track_name.present? && track_name != "不明"
    spotify_songs.push({ title: track_name, collection_name: collection_name, url: track_view_url})
  end
end

File.open("tmp/touhou_music_song_spotify.json", "w") do |f|
  f.puts JSON.pretty_generate(spotify_songs)
end

File.open("tmp/touhou_music_with_original_songs.tsv", "w") do |f|
  f.puts("circle_name\tcollection_name\tcollection_view_url\ttrack_count\ttrack_number\tapple_track_id\ttrack_name\toriginal_songs")
  Discography.includes(:songs).touhou_doujin.order(:release_date).each do |d|
    circle_name = d.copyright.gsub(/℗ \d{4} /, "")
    collection_view_url = d.collection_view_url&.gsub("?uo=4", "")
    track_count = d.track_count
    d.songs.each do |song|
      apple_track_id = song.apple_track_id
      collection_name = song.collection_name
      track_name = song.track_name
      track_number = song.track_number
      original_songs = song.original_songs.map(&:title).join("/")
      # next if original_songs.present?
      f.puts("#{circle_name}\t#{collection_name}\t#{collection_view_url}\t#{track_count}\t#{track_number}\t#{apple_track_id}\t#{track_name}\t#{original_songs}")
    end
  end
end

File.open("tmp/touhou_music_spotify_discography.tsv", "w") do |f|
  f.puts("apple_collection_id\tartist_name\tapple_music_collection_name\tyoutube_collection_name\tspotify_collection_name")
  Discography.touhou_doujin.touhou.each do |d|
    next if d.spotify_collection_name.present?
    id = d.apple_collection_id
    artist_name = d.artist_name
    apple_music_collection_name = d.apple_music_collection_name
    youtube_collection_name = d.youtube_collection_name
    spotify_collection_name = d.spotify_collection_name
    f.puts("#{id}\t#{artist_name}\t#{apple_music_collection_name}\t#{youtube_collection_name}\t#{spotify_collection_name}")
  end
end
