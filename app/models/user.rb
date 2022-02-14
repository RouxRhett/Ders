class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  has_many :targets,       dependent: :destroy
  has_many :tasks,         dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :unlock_lists,  dependent: :destroy
  attachment :image
end
