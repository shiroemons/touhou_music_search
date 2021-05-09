# == Schema Information
#
# Table name: discographies_circles
#
#  id               :uuid             not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  circles_id       :uuid             not null
#  discographies_id :uuid             not null
#
# Indexes
#
#  index_discographies_circles_on_circles_id        (circles_id)
#  index_discographies_circles_on_discographies_id  (discographies_id)
#
# Foreign Keys
#
#  fk_rails_...  (circles_id => circles.id)
#  fk_rails_...  (discographies_id => discographies.id)
#
class DiscographiesCircle < ApplicationRecord
  belongs_to :discography
  belongs_to :circle
end
