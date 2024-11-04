class Article < ApplicationRecord
  BANNED_KEYWORDS = %w[Harris Trump]
  TITLE_CONTAINS_BANNED_KEYWORDS_MESSAGE = "Post title contains a banned keyword"
  BODY_CONTAINS_BANNED_KEYWORDS_MESSAGE = "Post body contains a banned keyword"
  MINIMUM_BODY_LENGTH = 10
  include Visible
  has_many :comments
  belongs_to :user
  validates :title, presence: true
  validates :title, exclusion: { in: BANNED_KEYWORDS, message: TITLE_CONTAINS_BANNED_KEYWORDS_MESSAGE }
  validates :body, presence: true, length: { minimum: MINIMUM_BODY_LENGTH }
  validates :body, exclusion: { in: BANNED_KEYWORDS, message: BODY_CONTAINS_BANNED_KEYWORDS_MESSAGE }
  # validate :no_banned_keywords_in_title
  # private(
  #   def no_banned_keywords_in_title
  #     if title.present? && BANNED_KEYWORDS.any? { |word| title.downcase.include?(word) }
  #       errors.add(:title, "contains prohibited words")
  #     end
  #   end
  # )
end
