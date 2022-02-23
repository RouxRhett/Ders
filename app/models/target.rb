class Target < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  belongs_to :user
  belongs_to :category

  validates :goal, presence: true
  validates :reason, presence: true
  validates :deadline, presence: true
  validates :num_tgt, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 1,
  }
end
