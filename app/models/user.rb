class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  mount_uploader :picture, PictureUploader

  attr_accessor :remember_token
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save { email.downcase! }

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :picture_size

  # return hash value for the passed character string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # return a random token
  def User.new_token
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
    Post.where("user_id=?", id)
  end

  private

    def picture_size
      if picture.size > 5.megabytes
        error.add(:picture, "should be less than 5MB")
      end
    end
end
