FactoryBot.define do
  factory :review do
    restaurant_id { 1 }
    user_id { 1 }
    rate { 5 }
    comment { "Rpsecコメント" }
  end
end
