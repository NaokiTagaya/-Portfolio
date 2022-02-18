require 'rails_helper'

RSpec.describe 'User', type: :feature do
  scenario 'ログイン前のトップページ表示' do
    visit root_url

  end

  scenario 'ログイン後のトップページ表示' do
    # ログイン処理
    @user = FactoryBot.create(:regi_user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: "jiro_potepan@test.com"
    fill_in 'パスワード', with: "potepote1234"
    click_button 'ログイン'

    # コンテンツ表示
    expect(page).to have_content "ログインしました。"
    expect(page).to have_link 'ホーム', href: root_path
    expect(page).to have_link 'マイページ', href: users_profile_path
    expect(page).to have_link '店舗登録', href: new_restaurant_path
    expect(page).to have_link 'ログアウト', href: destroy_user_session_path
  end
end
