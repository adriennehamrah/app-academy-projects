# == Schema Information
#
# Table name: goalcomments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  goal_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goalcomment < ApplicationRecord
  validates :body, :goal_id, presence:true

  belongs_to :goal
end
