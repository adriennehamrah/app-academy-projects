# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :text             not null
#  url        :text
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, presence: {message: 'error - Select at least one sub'}

  belongs_to :author,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id,
    inverse_of: :posts

  has_many :post_subs,
    inverse_of: :post,
    dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments, inverse_of: :post
end
