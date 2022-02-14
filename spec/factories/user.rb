FactoryBot.define do
  factory :user do
    user_name { "Rspecテスト" }
    sex { 1 }
    age { 32 }
    email { "test@rspec.com" }
    password { "hogehoge1234" }
    password_confirmation { "hogehoge1234" }
  end

  factory :test_user, class: User do
    user_name { "Rspecユーザー" }
    age { 32 }
    sex { 1 }
    email { "rspec@test.com" }
    password { "hogohoge1234" }
    password_confirmation { "hogehoge1234" }
  end

  factory :login_user, class: User do
    user_name { "ログインユーザー" }
    age { 25 }
    sex { 2 }
    email { "rspeclogin@test.com" }
    password { "hogohoge1234" }
    password_confirmation { "hogehoge1234" }
  end
end
