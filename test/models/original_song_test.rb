# == Schema Information
#
# Table name: original_songs
#
#  code          :string           not null, primary key
#  composer      :string           default(""), not null
#  is_duplicate  :boolean          default(FALSE), not null
#  original_code :string           not null
#  title         :string           not null
#  track_number  :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_original_songs_on_code           (code) UNIQUE
#  index_original_songs_on_original_code  (original_code)
#
require "test_helper"

class OriginalSongTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
