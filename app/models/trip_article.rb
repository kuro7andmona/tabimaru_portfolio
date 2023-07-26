class TripArticle < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :prefecture
  belongs_to :season
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy #お気に入り機能
  # has_many :association_post_and_tags, dependent: :destroy
  # has_many :tags, through: :association_post_and_tags

  validates :title, presence: true
  validates :text, presence:true
  validates :image, attached: true, content_type: ["image/jpg", "image/jpeg"]

  def liked_by(user)
    Like.find_by(user_id: user.id, trip_article_id: id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
