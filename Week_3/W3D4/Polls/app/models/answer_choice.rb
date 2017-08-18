class AnswerChoice < ApplicationRecord
  validates :question_id, :text, presence: true

  belongs_to :question
  has_many :responses
end
