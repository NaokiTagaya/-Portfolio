require 'rails_helper'

RSpec.describe 'User', type: :system do
  before do
    @user = FactoryBot.create(:regi_user)
    sign_in @user
    visit root_path
  end

  describe 'ログイン後のトップページ表示' do
    it 'ログイン後のトップページが表示されている' do
      expect(page).to have_link 'ホーム', href: root_path
    end
  end
end