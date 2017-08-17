class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, :submitter_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :submitter_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  def self.random_code
    while true
      random = SecureRandom.urlsafe_base64(16)
      return random unless ShortenedUrl.exists?(short_url: random)
    end
  end

  def self.create_with_user_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    # visits.select('user_id').distinct.count
    visitors.count
  end

  def num_recent_uniques
    visits.select('user_id')
      .where('created_at > ?', 10.minutes.ago)
      .distinct.count
  end
end
