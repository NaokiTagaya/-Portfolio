class Restaurant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :reviews

  # 店舗位置情報表示
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # 正規表現
  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
  VALID_PHONE_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/

  # バリデーション
  validates :restaurant_name, presence: true
  validates :tel, presence: true
  validates :tel, format: { with: VALID_PHONE_REGEX }, allow_blank: true
  validates :zipcode, presence: true
  validates :zipcode, format: { with: VALID_POSTAL_CODE_REGEX }, allow_blank: true
  validates :address, presence: true

  mount_uploader :restaurant_image, RestaurantImageUploader
end
