require 'rails_helper'

RSpec.describe 'User', type: :feature do
  scenario 'トップページ' do
    before do
      @user = FactoryBot.create(:regi_user)
    end

    visit new_user_session_path
    fill_in 'メールアドレス', with: "jiro_potepan@test.com"
    fill_in 'パスワード', with: "potepote1234"
    click_button 'ログイン'

    expect(page).to have_link 'ホーム', href: root_path
    
    end
  end
end