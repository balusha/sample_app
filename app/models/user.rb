class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  before_save {self.email.downcase!}
  before_create :refresh_remember_token

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}

  def self.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
  	Digest::SHA1.hexdigest token
  end

  def feed
    Micropost.where("user_id = ?", self.id)
  end

  private	

    def refresh_remember_token
    	self.remember_token = User.encrypt(User.new_remember_token)
    end

end
