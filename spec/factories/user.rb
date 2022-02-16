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
    user_name { "Rpsecログインユーザー" }
    age { 25 }
    sex { 0 }
    email { "rspeclogin@test.com" }
    password { "hogohoge1234" }
    password_confirmation { "hogehoge1234" }
  end

  factory :profile_user, class: User do
    user_name { "Rspecプロフィールユーザー" }
    age { 25 }
    sex { 0 }
    email { "profile@test.com" }
    password { "hogohoge4567" }
    password_confirmation { "hogehoge4567" }
  end

  factory :delete_user, class: User do
    user_name { "削除太郎" }
    age { 28 }
    sex { 0 }
    email { "deleteuser@test.com" }
    password { "hogohoge4567" }
    password_confirmation { "hogehoge4567" }
  end
end
