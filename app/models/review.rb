class Review < ApplicationRecord
  belongs_to :restaurant, foreign_key: 'restaurant_id'
  belongs_to :user

  # バリデーション
  validates :rate, presence: true
  validates :rate, numericality: {
  less_than_or_equal_to: 5,
  greater_than_or_equal_to: 1 }
end
