class Post < ApplicationRecord
  belongs_to :user
  has_one    :music, dependent: :destroy
  accepts_nested_attributes_for :music, allow_destroy: true
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
end
