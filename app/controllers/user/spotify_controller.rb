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
      playlist = find_playlist(original_song_title)
      if playlist.present?
        playlist_tracks = playlist.tracks
        # 既存のプレイリストのtrackをすべて削除する
        until playlist_tracks.empty?
          playlist.remove_tracks!(playlist_tracks)
          playlist_tracks = playlist.tracks
        end
        spotify_track_ids = songs.map { |song| song.spotify_track_view_url.gsub('https://open.spotify.com/track/', '') }
        spotify_track_ids&.each_slice(50) do |ids|
          tracks = RSpotify::Track.find(ids)
          playlist.add_tracks!(tracks)
        end
      end
    end
  end

  def find_playlist(playlist_name)
    @playlists.find { |playlist| playlist.name == playlist_name }
  end
end
