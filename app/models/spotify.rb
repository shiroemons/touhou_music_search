class Spotify
  def self.fetch_albums_and_songs(id)
    return if id.blank?
    artist = RSpotify::Artist.find(id)
    artist.albums.each do |album|
      album_name = album.name
      album_url = album.external_urls['spotify']
      discographies = Discography.where(youtube_collection_name: album_name)
      discographies = Discography.where(collection_name: album_name) if discographies.blank?
      discographies = Discography.where(apple_music_collection_name: album_name) if discographies.blank?
      return if discographies.size != 1

      discography = discographies.first
      discography.update(spotify_collection_name: album_name, spotify_collection_view_url: album_url)

      discography_track_count = discography.track_count
      album_track_count = album.tracks.size
      album.tracks.each do |track|
        track_name = track.name
        track_url = track.external_urls['spotify']
        track_number = track.track_number

        song = Song.find_by(discography: discography, youtube_track_name: track_name)
        song ||= Song.find_by(discography: discography, track_name: track_name)
        if song.blank? && discography_track_count == album_track_count
          song ||= Song.find_by(discography: discography, track_number: track_number)
        end

        if song.blank?
          puts "\nalbum: #{album_name}\ttrack_name: #{track_name}"
          return
        end

        song.update(
          spotify_collection_name: album_name,
          spotify_collection_view_url: album_url,
          spotify_track_name: track_name,
          spotify_track_view_url: track_url
        )
      end
    end
  end
end