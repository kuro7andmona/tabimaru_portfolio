class TripArticle < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy #お気に入り機能

  validates :title, presence: true
  validates :text, presence:true
  validates :image, presence: true

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
