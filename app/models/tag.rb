class Tag < ApplicationRecord

has_many :association_post_and_tags, dependent: :destroy
has_many :trip_articles, through: :association_trip_article_and_tags

validates :tag_type, presence: true
end
