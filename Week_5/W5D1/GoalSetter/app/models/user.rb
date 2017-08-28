# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :text             not null
#  password_digest :text             not null
#  session_token   :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence:true
  validates :password, length: {minimum:6, allow_nil:true}
  attr_reader :password
  after_initialize :ensure_session_token

  has_many :goals

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = User.generate_token
    self.save
    self.session_token
  end

  def self.find_by_credentials(username, pw)
    user = User.find_by(username: username)
    return user if user && user.is_password?(pw)
  end

  def self.generate_token
    SecureRandom::urlsafe_base64
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_token
  end
end
