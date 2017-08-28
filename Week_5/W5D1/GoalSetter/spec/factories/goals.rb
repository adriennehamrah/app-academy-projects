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

FactoryGirl.define do
  factory :goal do
    title "MyText"
    details "MyText"
    private false
    completed false
    user_id 1
  end
end
