class Music < ApplicationRecord
  belongs_to :post
  validates :name,          presence: true
  validates :artist,        presence: true
  validates :artwork,       presence: true
  validates :collection_id, presence: true
end
