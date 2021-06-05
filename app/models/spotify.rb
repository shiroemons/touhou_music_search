class Spotify
  LIMIT = 50

  def self.fetch_albums_and_songs(id)
    return if id.blank?
    artist = RSpotify::Artist.find(id)
    offset = 0
    loop do
      albums = artist.albums(limit: LIMIT, offset: offset)
      fetch_albums(albums, artist)
      offset += LIMIT
      break if albums.count < LIMIT
    end
  end

  def self.fetch_albums(albums, artist)
    albums.each do |album|
      next if album.label != "東方同人音楽流通"
      album_name = album.name
      album_url = album.external_urls['spotify']
      discographies = Discography.where(youtube_collection_name: album_name)
      discographies = Discography.where(spotify_collection_name: album_name) if discographies.blank?
      discographies = Discography.where(collection_name: album_name) if discographies.blank?
      discographies = Discography.where(apple_music_collection_name: album_name) if discographies.blank?
      discographies = Discography.where("youtube_collection_name LIKE ?", "#{album_name}%") if discographies.blank?

      if discographies.size != 1
        File.open("tmp/touhou_music_spotify_all.tsv", "a") do |f|
          f.puts "#{artist.name}\t#{album.name}"
        end
        next
      end

      discography = discographies.first
      discography.update(spotify_collection_name: album_name, spotify_collection_view_url: album_url)

      offset = 0
      album_track_count = 0
      loop do
        tracks = album.tracks(limit: LIMIT, offset: offset)
        album_track_count += tracks.count
        offset += LIMIT
        break if tracks.count < LIMIT
      end
      offset = 0
      loop do
        tracks = album.tracks(limit: LIMIT, offset: offset)
        fetch_tracks(tracks, album, discography, album_track_count)
        offset += LIMIT
        break if tracks.count < LIMIT
      end
    end
  end

  def self.fetch_tracks(tracks, album, discography, album_track_count)
    album_name = album.name
    album_url = album.external_urls['spotify']
    discography_track_count = discography.track_count
    tracks.each do |track|
      track_name = track.name
      track_url = track.external_urls['spotify']
      track_number = track.track_number

      song = Song.find_by(discography: discography, youtube_track_name: track_name, track_number: track_number)
      song ||= Song.find_by(discography: discography, spotify_track_name: track_name)
      song ||= Song.find_by(discography: discography, track_name: track_name)
      if song.blank? && discography_track_count == album_track_count
        song ||= Song.find_by(discography: discography, track_number: track_number)
      end

      next if song.blank?

      song.update(
        spotify_collection_name: album_name,
        spotify_collection_view_url: album_url,
        spotify_track_name: track_name,
        spotify_track_view_url: track_url
      )
    end
  end
end