class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :trip_article
  belongs_to :admin
  validates :comment, presence: true, length: { maximum: 300 }
end
