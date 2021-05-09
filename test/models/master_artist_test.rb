# == Schema Information
#
# Table name: master_artists
#
#  id             :bigint           not null, primary key
#  key            :string           default(""), not null
#  name           :string           not null
#  streaming_type :string           default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class MasterArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
