require 'csv'

ActiveRecord::Base.connection.execute("TRUNCATE TABLE master_artists;")
insert_data = []
now = Time.now
master_artists = CSV.table('db/fixtures/master_artists.tsv', col_sep: "\t", converters: nil).each do |ma|
  insert_data << {
    name: ma[:name],
    apple_artist_id: ma[:apple_artist_id],
    created_at: now,
    updated_at: now
  }
end
MasterArtist.insert_all(insert_data)