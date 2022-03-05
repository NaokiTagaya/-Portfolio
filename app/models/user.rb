class User < ApplicationRecord
  has_many :reviews, through: :restaurants
  has_many :favorites, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # パスワード変更機能
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  # ゲストユーザー
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64(10)
      user.password_confirmation = user.password
      user.user_name = 'ゲストユーザー'
      user.sex = 0
      user.age = 30
    end
  end

  # 性別値
  enum sex: { male: 0, female: 1 }

  # 画像アップロード
  mount_uploader :image, ImageUploader

  # 正規表現を定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-z\d]+\z/i

  # バリデーション
  validates :user_name, presence: true
  validates :user_name, length: { maximum: 30 }, allow_blank: true
  validates :age, presence: true
  validates :age, numericality: true, allow_blank: true
  validates :email, presence: true
  validates :email, uniqueness: true, allow_blank: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true, on: :create
  validates :password, format: { with: VALID_PASSWORD_REGEX }, allow_blank: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :password_confirmation, length: { minimum: 6 }, allow_blank: true, on: :create
  validates :password_confirmation, format: { with: VALID_PASSWORD_REGEX }, allow_blank: true, on: :create
end
