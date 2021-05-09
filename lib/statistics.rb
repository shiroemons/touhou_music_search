puts "東方同人音楽流通"
puts "Apple Music"
puts "\t総アルバム数: #{Discography.touhou_doujin.count}枚 (※ただし、オリジナルのみ含む)"
puts "\t総曲数: #{Discography.touhou_doujin.sum(:track_count)}曲 (※ただし、オリジナル含む)"
puts "\t東方アルバム数: #{Discography.touhou_doujin.touhou.count}枚"
puts "\t東方楽曲数: #{Song.touhou_doujin.touhou.count}曲"
puts "\t東方歌詞あり楽曲数: #{Song.touhou_doujin.touhou.streamable.has_lyrics.count}曲"
puts "\tApple Music非提供楽曲: #{Song.touhou_doujin.touhou.not_streamable.count}曲"
puts "\nYouTube Music"
puts "\t総アルバム数: #{Discography.touhou_doujin.youtube_music.count}枚 (※ただし、オリジナルのみ含む)"
puts "\t総曲数: #{Discography.touhou_doujin.youtube_music.sum(:track_count)}曲 (※ただし、オリジナル含む)"
puts "\t東方アルバム数: #{Discography.touhou_doujin.touhou.youtube_music.count}枚"
puts "\t東方楽曲数: #{Song.touhou_doujin.touhou.youtube_music.count}曲"
puts "\nSpotify"
puts "\t総アルバム数: #{Discography.touhou_doujin.spotify.count}枚 (※ただし、オリジナルのみ含む)"
puts "\t総曲数: #{Discography.touhou_doujin.spotify.sum(:track_count)}曲 (※ただし、オリジナル含む)"
puts "\t東方アルバム数: #{Discography.touhou_doujin.touhou.spotify.count}枚"
puts "\t東方楽曲数: #{Song.touhou_doujin.touhou.spotify.count}曲"