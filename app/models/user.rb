class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :targets
  has_many :favorites
  has_many :unlock_lists
  # TODO ログインチェックメソッドを実装
end
