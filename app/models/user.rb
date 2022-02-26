class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(twitter)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.remote_image_url = auth.info.image
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.guest
    find_or_create_by!(name: 'guestuser', email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  has_many :targets,       dependent: :destroy
  has_many :tasks,         dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :unlock_lists,  dependent: :destroy
  attachment :image

  def self.dummy_email(auth)
    "#{auth[:uid]}@example.com"
  end
end
