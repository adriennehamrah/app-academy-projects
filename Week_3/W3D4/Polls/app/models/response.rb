class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :is_not_author

  belongs_to :answer_choice

  belongs_to :respondent,
  class_name: :User,
  primary_key: :id,
  foreign_key: :user_id

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  has_one :question,
  through: :answer_choice

  def respondent_already_answered?
    sibling_responses.any? do |response|
      response.user_id = self.user_id
    end
  end

  def is_not_author
    if question.poll.user_id = self.user_id
      self.errors[:author] << "author cannot answer own polls"
    end
  end

end
