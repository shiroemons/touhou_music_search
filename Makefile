RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

add-artist:
	bin/rails db:seed
	bin/rails r bin/scripts/001_fetch_apple_music_albums_using_the_itunes_api.rb
	bin/rails r bin/scripts/002_fetch_apple_music_songs_using_the_itunes_api.rb
	bin/rails r bin/scripts/003_fetch_apple_music_various_artists_album_and_songs_using_the_itunes_api.rb
	bin/rails r bin/scripts/004_fetch_touhou_music_using_the_apple_music_api.rb

file-export:
	bin/rails r lib/export.rb

statistics:
	bin/rails r lib/statistics.rb