# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: "admin@admin", password: "823259")

prefecture_names = [
  "北海道",
  "青森県",
  "岩手県",
  "宮城県",
  "秋田県",
  "山形県",
  "福島県",
  "茨城県",
  "栃木県",
  "群馬県",
  "埼玉県",
  "千葉県",
  "東京都",
  "神奈川県",
  "新潟県",
  "富山県",
  "石川県",
  "福井県",
  "山梨県",
  "長野県",
  "岐阜県",
  "静岡県",
  "愛知県",
  "三重県",
  "滋賀県",
  "京都府",
  "大阪府",
  "兵庫県",
  "奈良県",
  "和歌山県",
  "鳥取県",
  "島根県",
  "岡山県",
  "広島県",
  "山口県",
  "徳島県",
  "香川県",
  "愛媛県",
  "高知県",
  "福岡県",
  "佐賀県",
  "長崎県",
  "熊本県",
  "大分県",
  "宮崎県",
  "鹿児島県",
  "沖縄県"
]

prefectures = prefecture_names.map do |name|
  Prefecture.create!(name: name)
end

season_names = %w(
  春
  春夏
  夏
  夏秋
  秋
  秋冬
  冬
  冬春
)

seasons = season_names.map do |name|
  Season.create!(name: name)
end

if Rails.env.development?
  file_path = Rails.root.join('app/assets/images/no_image.jpg')

  (1..5).each do |n|
    user = User.create!(
      name: "user_#{n}",
      nickname: "user_#{n}_nickname",
      email: "user#{n}@test.com",
      password: "password",
      introduction: "text" * rand(3..5)
    )

    (1..rand(1..3)).each do |m|
      trip_article = user.trip_articles.build(
        prefecture_id: prefectures.sample.id,
        season_id: seasons.sample.id,
        title: "title#{n}_#{m}",
        text: "text" * rand(3..7)
      )
      trip_article.image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      trip_article.save!
    end
  end
end