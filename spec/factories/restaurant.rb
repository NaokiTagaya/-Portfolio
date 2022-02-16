FactoryBot.define do
  factory :restaurant do
    restaurant_name { "レストランRspec" }
    tel { "03-1234-5678" }
    zipcode { "150-0000" }
    address { "東京都渋谷区渋谷２丁目" }
    registered_user_id { 1 }
  end

  factory :test_restaurant, class: Restaurant do
    restaurant_name { "レストランRspec" }
    tel { "03-1234-5678" }
    zipcode { "150-0000" }
    address { "東京都渋谷区渋谷２丁目" }
    registered_user_id { 1 }
  end
end
