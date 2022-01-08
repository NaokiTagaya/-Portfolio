class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :reviews

  # 正規表現
  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/

  # バリデーション
  validates :restaurant_name, presence: true
  validates :tel, presence: true, format: { with: VALID_PHONE_REGEX }
  validates :zipcode, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :address, presence: true

  mount_uploader :restaurant_image, RestaurantImageUploader
end
