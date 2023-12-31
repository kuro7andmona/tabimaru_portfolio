# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: "admin@admin.com", password: "823259")

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
  夏
  秋
  冬
)

seasons = season_names.map do |name|
  Season.create!(name: name)
end

User.create!([
  {name: "国内太郎", nickname: "こくた", email: "kokunai@taro", password: "354114", introduction: "国内放浪中" },
  {name: "東北県太", nickname: "けん", email: "touhoku@kenta", password: "354114", introduction: "東北が好きです" },
  {name: "北海道智子", nickname: "みっちゃん", email: "hokkai@mitiko", password: "354114", introduction: "海が好きです" },
  {name: "九州京子", nickname: "ピカ子", email: "kyusyuu@kyoko", password: "354114", introduction: "明太子love" },
  {name: "四国たかし", nickname: "たかちゃん", email: "sikoku@takasi", password: "354114", introduction: "趣味は釣りです" },
  {name: "沖縄花子", nickname: "hana", email: "okinawa@hanako", password: "354114", introduction: "マリンスポーツが趣味です" }

])

TripArticle.create!([
  {user_id: 1, prefecture_id: 32, season_id: 2, title: "デニムストリート", text: "おしゃれなデニムがたくさん", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/denimustreet.jpg"),filename: "denimustreet.jpg")
  },
  {user_id: 2, prefecture_id: 43, season_id: 4, title: "日本滝１００選", text: "原尻の滝は迫力満点！", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/haraziritaki.jpg"),filename: "haraziritaki.jpg")
  },
  {user_id: 3, prefecture_id: 17, season_id: 1, title: "禄剛埼灯台", text: "能登にある最先端の灯台", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/noto-todai.jpg"),filename: "noto-todai.jpg")
  },
  {user_id: 4, prefecture_id: 43, season_id: 4, title: "藁マンモス", text: "畑にポツンとマンモス", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/waramannmosu.jpg"),filename: "waramannmosu.jpg")
  },
  {user_id: 5, prefecture_id: 43, season_id: 4, title: "湯けむり展望台", text: "湯けむりと夜景のコラボ", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/yuhuinyakei.jpg"),filename: "yuhuinnyakei.jpg")
  },
  {user_id: 6, prefecture_id: 2, season_id: 3, title: "十和田市現代美術館", text: "イケてる青森のアートが見れる。", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/aomorib-uma.jpg"),filename: "aomorib-uma.jpg")
  },
  {user_id: 1, prefecture_id: 46, season_id: 3, title: "苔アート", text: "一度見る価値あり！", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kokeart.jpg"),filename: "kokeart.jpg")
  },
  {user_id: 2, prefecture_id: 10, season_id: 2, title: "土合駅", text: "めっちゃモグラの駅", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/doai.jpg"),filename: "doai.jpg")
  },
  ])
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