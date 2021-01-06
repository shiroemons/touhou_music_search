class OriginalSong < ApplicationRecord
  self.primary_key = :code

  belongs_to :original,
             foreign_key: :original_code,
             primary_key: :code,
             inverse_of: :original_songs
end
