# == Schema Information
#
# Table name: master_artists
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  apple_artist_id :bigint           not null
#
class MasterArtist < ApplicationRecord
end
