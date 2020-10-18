class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy

  mount_uploader :picture, PictureUploader

  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  before_save { email.downcase! }

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate  :picture_size
  validates :profile, length: { maximum: 140 }

  # return hash value for the given character string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # return a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # remember new token in database for permanent session
  def remember_new_token
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # return true when the passed token is equal to digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # discard a remember token
  def forget_token
    update_attribute(:remember_digest, nil)
  end

  # trial feed
  def feed
    following_ids = "SELECT followed_id FROM relationships
    WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
    OR user_id = :user_id", user_id: id)
  end

  # follow user
  def follow(other_user)
    following << other_user
  end

  # unfollow user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # return true when an user following another user
  def following?(other_user)
    following.include?(other_user)
  end

  # like a post
  def like(post)
    like_posts << post
  end

  # unlike a post
  def unlike(post)
    like_posts.delete(post)
  end

  # return true when an user likes a post
  def like?(post)
    like_posts.include?(post)
  end

  private

  def picture_size
    return unless picture.size > 5.megabytes

    error.add(:picture, "should be less than 5MB")
  end
end
