class Task < ApplicationRecord
  belongs_to :target

  validates :name, presence: true
end
