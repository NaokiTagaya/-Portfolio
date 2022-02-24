FactoryBot.define do
  factory :favorite do
    user_id { 1 }
    restaurant_id { 1 }
  end

  factory :favorite_1, class: Favorite do
    user_id { 1 }
    restaurant_id { 1 }
  end

  factory :favorite_2, class: Favorite do
    user_id { 1 }
    restaurant_id { 1 }
  end
end
