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

    # コンテンツ表示
    expect(page).to have_selector("img[src$='default_icon.png']")
    expect(page).to have_content 'ポテパン次郎'
    expect(page).to have_selector("img[alt=1]")
    expect(page).to have_selector("img[alt=2]")
    expect(page).to have_selector("img[alt=3]")
    expect(page).to have_selector("img[alt=4]")
    expect(page).to have_selector("img[alt=5]")
    expect(page).to have_selector("img[src$='star-on-88233ad1abcd2282b53edb9465a6bef42fd32de319f014e4059353e4fd8a7e0a.png']")
    expect(page).to have_selector("img[src$='star-on-88233ad1abcd2282b53edb9465a6bef42fd32de319f014e4059353e4fd8a7e0a.png']")
    expect(page).to have_selector("img[src$='star-on-88233ad1abcd2282b53edb9465a6bef42fd32de319f014e4059353e4fd8a7e0a.png']")
    expect(page).to have_selector("img[src$='star-on-88233ad1abcd2282b53edb9465a6bef42fd32de319f014e4059353e4fd8a7e0a.png']")
    expect(page).to have_selector("img[src$='star-off-cf9b07584547d5d561dfac9cdbf7b6a530cb72a1b7a1096411966036c4017d38.png']")
    expect(page).to have_content '4.0'
    expect(page).to have_content '評価は4点です。'
  end

  scenario 'マイページ内の投稿レビュー一覧を閲表示' do
    
  end

  scenario 'レビュー投稿' do

  end
end