class Like < ApplicationRecord
  belongs_to :user
  belongs_to :trip_article #お気に入り機能

 #ユーザーが１つの投稿に対してお気に入り登録できる回数を１回
  validates :user_id, uniqueness: { scope: :trip_article_id }

end
