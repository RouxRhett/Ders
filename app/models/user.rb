class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  has_many :targets,       dependent: :destroy
  has_many :tasks,         dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :unlock_lists,  dependent: :destroy
  attachment :image
end
