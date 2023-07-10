class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :trip_article
  validates :comment, presence: true, length: { maximum: 300 }
end
