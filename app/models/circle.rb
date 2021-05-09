# == Schema Information
#
# Table name: circles
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Circle < ApplicationRecord
  has_many :discographies_circles, dependent: :destroy
  has_many :discographies, through: :discographies_circles
end
