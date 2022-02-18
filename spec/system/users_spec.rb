require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'top.html.erb' do
    before do
      @user = FactoryBot.create(:regi_user)
    end
    
    context 'User log in' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: "jiro_potepan@test.com"
        fill_in 'パスワード', with: "potepote1234"
        click_button 'ログイン'
      end

      it 'ログイン後のトップページが表示されている' do
        expect(page).to have_link 'ホーム', href: root_path
      end
    end
  end
end