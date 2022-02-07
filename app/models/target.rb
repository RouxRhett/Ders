class Target < ApplicationRecord
  has_many :targets
  has_many :tasks

  belongs_to :user
  belongs_to :category
end
