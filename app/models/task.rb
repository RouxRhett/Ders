class Task < ApplicationRecord
  belongs_to :target
  belongs_to :user

  validates :name, presence: true
  validates :time, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 1,
  }
end
