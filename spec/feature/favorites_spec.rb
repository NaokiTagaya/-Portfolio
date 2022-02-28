require 'rails_helper'

RSpec.describe 'Favorite', type: :feature, js: true do
  before do
    @user1 = FactoryBot.create(:regi_user)
    @user2 = FactoryBot.create(:login_user)
    @restaurant1 = FactoryBot.create(:kanagawa_restaurant)
    @restaurant2 = FactoryBot.create(:gunma_restaurant)
    @restaurant3 = FactoryBot.create(:edit_restaurant, registered_user_id: @user2.id)
    @favorite_b1 = FactoryBot.create(:favorite_1, user_id: @user1.id, restaurant_id: @restaurant1.id)
    @favorite_b2 = FactoryBot.create(:favorite_2, user_id: @user1.id, restaurant_id: @restaurant2.id)
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
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # エリア検索を行い、店舗詳細画面に遷移
    click_link 'ホーム'
    fill_in 'large-keyword', with: '原宿'
    find('input#large-search').click
    find('#detail-button').click

    # お気に入り登録前
    expect(page).to have_css '.far'
    expect(page).to have_css '.star-count1', text: '0'

    # お気に入り登録押下後
    find('.far').click
    expect(page).to have_css '.fas'
    expect(page).to have_css '.star-count2', text: '1'

    # マイページコンテンツ表示
    click_link 'マイページ'
    expect(page).to have_selector("img[src$='no_image.jpg']")
    expect(page).to have_content 'テスト店舗原宿'
    expect(page).to have_content '〒372-0851 東京都渋谷区神宮前1'
    expect(page).to have_content @favorite_b1.created_at.strftime("%Y.%m.%d")
    expect(page).to have_link '店舗詳細', href: restaurant_path(@restaurant3.id)
  end

  scenario 'お気に入り解除後、マイページ内のお気に入り一覧に反映されているか確認' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # エリア検索を行い、店舗詳細画面に遷移
    click_link 'ホーム'
    fill_in 'large-area', with: '群馬'
    find('input#large-search').click
    find('#detail-button').click

    # お気に入り解除前
    expect(page).to have_selector '.fas'
    expect(page).to have_selector '.star-count2', text: '1'

    #お気に入り解除押下後
    find('.fas').click
    expect(page).to have_selector '.far'
    expect(page).to have_selector '.star-count1', text: '0'

    # マイページコンテンツ表示
    click_link 'マイページ'
    expect(page).to_not have_selector("img[src$='no_image.jpg']")
    expect(page).to_not have_content '群馬レストラン'
    expect(page).to_not have_content '〒372-0851 群馬県伊勢崎市上蓮町６５７'
    expect(page).to_not have_content @favorite_b1.created_at.strftime("%Y.%m.%d")
    expect(page).to_not have_link '店舗詳細', href: restaurant_path(@restaurant2.id)
  end

  scenario '自身で登録した店舗はお気に入りボタン非表示' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'rspeclogin@test.com'
    fill_in 'パスワード', with: 'hogohoge1234'
    click_button 'ログイン'

    # エリア検索を行い、店舗詳細画面に遷移
    fill_in 'large-keyword', with: '原宿'
    find('input#large-search').click
    find('#detail-button').click

    # お気に入りボタン部分が非表示
    expect(page).to_not have_selector '.favorite-btn-part'
  end
end
