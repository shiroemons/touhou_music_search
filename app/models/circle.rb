class Circle < ApplicationRecord
  has_many :discographies_circles, dependent: :destroy
  has_many :discographies, through: :discographies_circles
end
