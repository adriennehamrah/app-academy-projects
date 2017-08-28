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

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  subject(:user) do
    User.new(username: "user1", password: "123456")
  end

  describe 'password encrpytion' do
    it 'encrypts the password' do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "user2", password: "password")
    end
  end

  describe '#is_password?' do
    it 'verifies the password' do
      expect(user.is_password?('123456')).to be true
    end
  end

  describe '#reset_token!' do
    it 'resets the session token' do
      old_token = user.session_token
      user.reset_token!
      expect(user.session_token).to_not eq(old_token)
    end

    it 'calls save' do
      expect(user).to receive(:save)
      user.reset_token!
    end

    it 'returns new session token' do
      expect(user.reset_token!).to eq(user.session_token)
    end
  end

  describe '::find_by_credentials' do
    # it 'finds user given valid credentials' do
    #   expect(User.find_by_credentials(
    #     "user1", "123456") ).to eq(user)
    # end

    it 'returns nil, given wrong credentials' do
      expect(User.find_by_credentials(
        'othername', 'wrongpassword')).to eq(nil)
    end
  end
end
