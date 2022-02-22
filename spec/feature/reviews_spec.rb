require 'rails_helper'

RSpec.describe 'Review', type: :feature do
  before do
    @user = FactoryBot.create(:regi_user)
    @restaurant1 = FactoryBot.create(:kanagawa_restaurant)
    @restaurant2 = FactoryBot.create(:gunma_restaurant)
    @four_rate = FactoryBot.create(:four_rate, restaurant_id: @restaurant1.id, user_id: @user.id)
    @three_rate = FactoryBot.create(:three_rate, restaurant_id: @restaurant2.id, user_id: @user.id)
  end

  scenario '店舗のレビュー一覧を表示' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # エリアを入力して検索
    fill_in 'large-area', with: '神奈川'
    find('input#large-search').click
    find('#detail-button').click

    # コンテンツ表示
    expect(page).to have_selector("img[src$='default_icon.png']")
    expect(page).to have_content 'ポテパン次郎'
    expect(page).to have_content '4.0'
    expect(page).to have_content '評価は4点です。'
  end

  scenario 'マイページ内の投稿レビュー一覧を閲表示' do
  end

  scenario 'レビュー投稿' do
  end
end
