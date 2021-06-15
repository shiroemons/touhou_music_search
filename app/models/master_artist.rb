# == Schema Information
#
# Table name: master_artists
#
#  id             :bigint           not null, primary key
#  key            :string           default(""), not null
#  name           :string           not null
#  streaming_type :string           default(NULL), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class MasterArtist < ApplicationRecord
  enum streaming_type: { apple_music: 'apple_music', spotify: 'spotify' }
end
