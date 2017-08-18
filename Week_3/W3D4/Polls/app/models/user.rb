class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true 

  has_many :authored_polls,
  class_name: :Poll,
  primary_key: :id,
  foreign_key: :user_id

  has_many :responses
end
