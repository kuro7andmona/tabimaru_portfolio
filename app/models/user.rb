class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :trip_articles, dependent: :destroy#旅行記事
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy#お気に入り機能

  validates :nickname, presence: true, length: { minimum: 2 , maximum: 20 }, uniqueness: true
  validates :name, presence: true, length: { minimum: 2 , maximum: 20 }, uniqueness: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      # image.variant(resize_to_limit: [width, height]).processed
      image.variant(gravity: :center, resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0")
  end

  def self.guest
    find_or_create_by!(email: 'guest@guest.mail') do |user|
      user.name = 'ゲスト'
      user.nickname = 'ゲストニックネーム'
      user.password = SecureRandom.urlsafe_base64
    end
  end
  def guest_user?
      email == 'guest@guest.mail'
  end
end
