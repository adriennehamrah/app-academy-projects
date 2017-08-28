# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :text             not null
#  details    :text
#  private    :boolean          default(FALSE), not null
#  completed  :boolean          default(FALSE), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ApplicationRecord
  validates :title, :user_id, presence:true

  belongs_to :user
end
