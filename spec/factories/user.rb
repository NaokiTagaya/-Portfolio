FactoryBot.define do
  factory :user do
    user_name { "Rspecテスト" }
    sex { 1 }
    age { 32 }
    email { "test@rspec.com" }
    password { "hogehoge1234" }
    password_confirmation { "hogehoge1234" }
  end

  factory :user_taro do
    user_name { "太郎" }
    sex { 1 }
    age { 25 }
    email { "taro@example.com" }
    password { "hogehoge1234" }
    password_confirmation { "hogehoge1234" }
  end
end