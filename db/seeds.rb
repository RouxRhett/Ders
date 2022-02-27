# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理用テストアカウント
Admin.create!(
  email: 'test@test.com',
  password: 'testpass'
)

# ユーザ用テストアカウント
User.create!(
  email: 'test@test.com',
  name: 'hogehoge',
  password: 'testpass',
)

# カテゴリテストデータ
category_list = ['時間','回数','ページ']
category_list.each do |category|
  Category.create!(
    name: category
  )
end

# アチーブメント用データ
achievement_list = [['目標設定', 0], ['タスクを作成', 1], ['達成済みに', 2]]
achievement_list.each do |achievement|
  Achievement.create!(
    name: "初めて#{achievement[0]}した!",
    group: achievement[1],
    number: 1,
  )
  9.times do |num|
    Achievement.create!(
      name: "#{num + 2}回、#{achievement[0]}した!",
      group: achievement[1],
      number: num + 2,
    )
  end
end
