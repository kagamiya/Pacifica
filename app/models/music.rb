class Music < ApplicationRecord
  belongs_to :post
  validates :post_id, presence: true
  validates :name,    presence: true
  validates :artist,  presence: true
  validates :artwork, presence: true
end
