require 'rails_helper'

RSpec.describe 'Favorite', type: :feature do
  before do
    @user = FactoryBot.create(:regi_user)
    @user1 = FactoryBot.create(:profile_user)
    @restaurant1 = FactoryBot.create(:kanagawa_restaurant)
    @restaurant2 = FactoryBot.create(:gunma_restaurant)
    @favorite_b1 = FactoryBot.create(:favorite_1, user_id: @user.id, restaurant_id: @restaurant1.id)
    @favorite_b2 = FactoryBot.create(:favorite_2, user_id: @user.id, restaurant_id: @restaurant2.id)
  end

  scenario 'マイページ内のお気に入り一覧を表示' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # マイページ遷移
    click_link 'マイページ'

    # お気に入り一覧コンテンツ表示
    expect(page).to have_selector("img[src$='no_image.jpg']")
    expect(page).to have_content 'Rspecレストラン'
    expect(page).to have_content '〒220-0012 神奈川県横浜市西区みなとみらい２丁目３'
    expect(page).to have_content @favorite_b1.created_at.strftime("%Y.%m.%d")
    expect(page).to have_link '店舗詳細', href: restaurant_path(@restaurant1.id)
    expect(page).to have_selector("img[src$='no_image.jpg']")
    expect(page).to have_content '群馬レストラン'
    expect(page).to have_content '〒372-0851 群馬県伊勢崎市上蓮町６５７'
    expect(page).to have_content @favorite_b2.created_at.strftime("%Y.%m.%d")
    expect(page).to have_link '店舗詳細', href: restaurant_path(@restaurant2.id)
  end

  scenario 'お気に入り登録後、マイページ内のお気に入り一覧に反映されているか確認' do
  end

  scenario 'お気に入り解除後、マイページ内のお気に入り一覧に反映されているか確認' do
  end
end
