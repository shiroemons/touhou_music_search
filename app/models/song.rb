class Song < ApplicationRecord
  belongs_to :discography

  scope :touhou, -> { where(is_touhou: true) }
  scope :not_touhou, -> { where(is_touhou: false) }
  scope :streamable, -> { where(is_streamable: true)}
  scope :not_streamable, -> { where(is_streamable: false)}
end
