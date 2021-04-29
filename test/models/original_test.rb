# == Schema Information
#
# Table name: originals
#
#  code          :string           not null, primary key
#  original_type :string           not null
#  series_order  :float            not null
#  short_title   :string           not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class OriginalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
