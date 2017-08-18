class Question < ApplicationRecord
  validates :poll_id, :text, presence: true

  has_many :answer_choices

  belongs_to :poll

  has_many :responses,
  through: :answer_choices

  def results
    results = Hash.new(0)
    self.responses.each do |response|
      results[response.answer_choice.text] += 1
    end
    results
  end

  def better_results
    all_responses = self.responses.include(answer_choice: :text)
    results = Hash.new(0)
    all_responses.each do |response|
      results[response.answer_choice.text] += 1
    end
    results
  end

end
