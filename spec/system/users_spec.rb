require 'rails_helper'

RSpec.describe 'User', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'ログイン後のトップページ表示' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
      fill_in 'パスワード', with: 'potepote1234'
      click_button 'ログイン'
    end

    it 'ログイン後のトップページが表示されている' do
      expect(page).to have_link 'ホーム', href: root_path
      expect(page).to have_link 'マイページ', href: users_profile_path
      expect(page).to have_link '店舗登録', href: new_restaurant_path
      expect(page).to have_link 'ログアウト', href: destroy_user_session_path
    end
  end
end