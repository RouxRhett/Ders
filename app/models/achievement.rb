class Achievement < ApplicationRecord
  has_many :unlock_lists

  # achievement.groupについて
  # 0 = 目標を作成する時
  # 1 = タスクを作成した時
  # 2 = 目標を達成済みにした時
end
