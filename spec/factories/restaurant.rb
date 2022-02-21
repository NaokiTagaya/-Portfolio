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

  factory :kanagawa_restaurant, class: Restaurant do
    restaurant_name { "Rspecレストラン" }
    tel { "045-682-1000" }
    zipcode { "220-0012" }
    address { "神奈川県横浜市西区みなとみらい２丁目３" }
    registered_user_id { 1 }
  end

  factory :gunma_restaurant, class: Restaurant do
    restaurant_name { "群馬レストラン" }
    tel { "0270-32-0000" }
    zipcode { "372-0851" }
    address { "群馬県伊勢崎市上蓮町６５７" }
    registered_user_id { 1 }
  end

  factory :edit_restaurant, class: Restaurant do
    restaurant_name { "テスト店舗原宿" }
    tel { "03-6434-0000" }
    zipcode { "372-0851" }
    address { "東京都渋谷区神宮前1" }
  end
end
