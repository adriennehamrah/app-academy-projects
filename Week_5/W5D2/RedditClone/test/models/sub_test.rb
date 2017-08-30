# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :text             not null
#  description :text             not null
#  user_id     :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class SubTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
