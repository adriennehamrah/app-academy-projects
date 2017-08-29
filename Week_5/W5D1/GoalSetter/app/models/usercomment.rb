# == Schema Information
#
# Table name: usercomments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Usercomment < ApplicationRecord
  validates :body, :user_id, presence:true

  belongs_to :user
end
