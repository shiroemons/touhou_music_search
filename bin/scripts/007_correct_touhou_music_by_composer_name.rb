def correct_touhou_music(discography)
  discography.songs.each do |song|
    composer_name = song.composer_name
    if song.is_touhou && !(composer_name.include?('ZUN') || composer_name.include?('あきやまうに'))
      song.update(is_touhou: false)
    end
  end
  if discography.songs.each.all? { |song| !song.is_touhou }
    discography.update(is_touhou: false)
  end
end

album_count = 0
max_albums = Discography.touhou.count
Discography.touhou.find_each do |discography|
  correct_touhou_music(discography)
  album_count += 1
  print "\rアルバム: #{album_count}/#{max_albums} Progress: #{(album_count * 100.0 / max_albums).round(1)}%"
end