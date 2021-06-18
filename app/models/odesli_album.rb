# == Schema Information
#
# Table name: odesli_albums
#
#  id             :uuid             not null, primary key
#  fetched_at     :datetime         not null
#  payload        :jsonb            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  discography_id :uuid             not null
#
# Indexes
#
#  index_odesli_albums_on_discography_id  (discography_id)
#
# Foreign Keys
#
#  fk_rails_...  (discography_id => discographies.id)
#
class OdesliAlbum < ApplicationRecord
  belongs_to :discography
end
