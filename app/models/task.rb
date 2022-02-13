class Task < ApplicationRecord
  belongs_to :target
  belongs_to :user

  validates :name, presence: true
end
