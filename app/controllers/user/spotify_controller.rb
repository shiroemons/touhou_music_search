class User::SpotifyController < ApplicationController
  LIMIT = 50
  def index
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    offset = 0
    @playlists = []
    loop do
      playlists = @spotify_user.playlists(limit: LIMIT, offset: offset)
      offset += LIMIT
      @playlists.push(*playlists)
      break if playlists.count < LIMIT
    end
    @playlists.reverse!
    # Original.includes(:original_songs).windows.each { |original| add_tracks(original) }
    # Original.includes(:original_songs).pc98.each { |original| add_tracks(original) }
    # Original.includes(:original_songs).zuns_music_collection.each { |original| add_tracks(original) }
    # Original.includes(:original_songs).akyus_untouched_score.each { |original| add_tracks(original) }
  end

  private

  def add_tracks(original)
    original.original_songs.each do |os|
      next if os.is_duplicate
      songs = os.songs.spotify
      next if songs.size == 0
      original_song_title = os.title
      playlist = playlist_find_or_create(original_song_title)
      spotify_track_ids = songs.map {|song| song.spotify_track_view_url.gsub('https://open.spotify.com/track/', '') }
      spotify_track_ids&.each_slice(50) do |ids|
        tracks = RSpotify::Track.find(ids)
        playlist.add_tracks!(tracks)
      end
    end
  end

  def playlist_find_or_create(playlist_name)
    playlist = @spotify_user.playlists.find { |playlist| playlist.name == playlist_name}
    playlist ||= @spotify_user.create_playlist!(playlist_name)
    playlist
  end
end
