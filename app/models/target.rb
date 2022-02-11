class Target < ApplicationRecord
  has_many :tasks

  belongs_to :user
  belongs_to :category

  validates :goal, presence: true
  validates :reason, presence: true
end
