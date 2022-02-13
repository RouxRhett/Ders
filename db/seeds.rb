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
Category.create!(
  name: 'hoge'
)

# アチーブメント用データ
Achievement.create!(
  name: '初めての目標設定をした!',
  group: 0,
  number: 1,
)
