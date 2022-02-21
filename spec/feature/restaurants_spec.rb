require 'rails_helper'

RSpec.describe 'Restaurant', type: :feature do
  before do
    @user = FactoryBot.create(:regi_user)
    @restaurant1 = FactoryBot.create(:test_restaurant)
    @restaurant2 = FactoryBot.create(:kanagawa_restaurant)
    @restaurant3 = FactoryBot.create(:gunma_restaurant)
  end

  scenario '店舗を全件検索' do
    # トップページ
    visit root_url

    # 何も入力せずに検索
    find('input#large-search').click

    # コンテンツ表示
    expect(page).to have_content '検索結果：3件'
    expect(page).to have_content 'レストランRspec'
    expect(page).to have_content '東京都渋谷区渋谷２丁目'
    expect(page).to have_content 'Rspecレストラン'
    expect(page).to have_content '神奈川県横浜市西区みなとみらい２丁目３'
    expect(page).to have_content '群馬レストラン'
    expect(page).to have_content '群馬県伊勢崎市上蓮町６５７'
  end

  scenario 'エリアを絞って店舗検索' do
    # トップページ
    visit root_url

    # 何も入力せずに検索
    fill_in 'large-area', with: '群馬'
    find('input#large-search').click

    # コンテンツ表示
    expect(page).to have_content '検索結果：1件'
    expect(page).to have_content '群馬レストラン'
    expect(page).to have_content '群馬県伊勢崎市上蓮町６５７'
  end

  scenario 'キーワードを絞って店舗検索' do
    # トップページ
    visit root_url

    # 何も入力せずに検索
    fill_in 'large-keyword', with: 'Rspec'
    find('input#large-search').click

    # コンテンツ表示
    expect(page).to have_content '検索結果：2件'
    expect(page).to have_content 'レストランRspec'
    expect(page).to have_content '東京都渋谷区渋谷２丁目'
    expect(page).to have_content 'Rspecレストラン'
    expect(page).to have_content '神奈川県横浜市西区みなとみらい２丁目３'
  end

  scenario 'エリアとキーワード両方入力して店舗検索' do
    # トップページ
    visit root_url

    # 何も入力せずに検索
    fill_in 'large-area', with: '神奈川'
    fill_in 'large-keyword', with: 'Rspec'
    find('input#large-search').click

    # コンテンツ表示
    expect(page).to have_content '検索結果：1件'
    expect(page).to have_content 'Rspecレストラン'
    expect(page).to have_content '神奈川県横浜市西区みなとみらい２丁目３'
  end

  scenario '非ログイン時の店舗詳細画面表示' do
    # トップページ
    visit root_url

    # 条件を入力して検索
    fill_in 'large-area', with: '渋谷'
    find('input#large-search').click

    # 検索画面の詳細ボタンを押下
    find('#detail-button').click

    # 詳細画面表示
    expect(page).to have_selector '.restaurant-name-title', text: 'レストランRspec'
    expect(page).to have_selector '.detail-info-text', text: 'レストランRspec 基本情報'
    expect(page).to have_content '03-1234-5678'
    expect(page).to have_content '〒150-0000 東京都渋谷区渋谷２丁目'
    expect(page).to have_content 'レビュー投稿は会員のみご利用できます。'
    expect(page).to have_content '会員登録はこちら'
    expect(page).to have_selector("img[src$='no_image.jpg']")
  end

  scenario 'ログイン時の店舗詳細画面表示' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # 条件を入力して検索
    fill_in 'large-area', with: '渋谷'
    find('input#large-search').click

    # 検索画面の詳細ボタンを押下
    find('#detail-button').click

    # 詳細画面表示
    expect(page).to have_selector '.restaurant-name-title', text: 'レストランRspec'
    expect(page).to have_selector '.detail-info-text', text: 'レストランRspec 基本情報'
    expect(page).to have_content '03-1234-5678'
    expect(page).to have_content '〒150-0000 東京都渋谷区渋谷２丁目'
    expect(page).to_not have_content 'レビュー投稿は会員のみご利用できます。'
    expect(page).to_not have_content '会員登録はこちら'
    expect(page).to have_selector("img[src$='no_image.jpg']")
  end

  scenario '店舗登録と表示' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # 店舗登録を押下
    click_link '店舗登録'

    # 必要項目を入力して登録する
    fill_in '店舗名', with: "テイクアウト店舗"
    fill_in '郵便番号', with: "194-8589"
    fill_in '所在地', with: "東京都町田市鶴間３丁目"
    fill_in '電話番号', with: "042-788-0000"
    click_button '登録'

    # 店舗詳細画面表示
    expect(page).to have_selector '.restaurant-name-title', text: 'テイクアウト店舗'
    expect(page).to have_selector '.detail-info-text', text: 'テイクアウト店舗 基本情報'
    expect(page).to have_content '042-788-0000'
    expect(page).to have_content '〒194-8589 東京都町田市鶴間３丁目'
    expect(page).to_not have_content 'レビュー投稿は会員のみご利用できます。'
    expect(page).to_not have_content '会員登録はこちら'
    expect(page).to have_selector("img[src$='no_image.jpg']")

    # マイページ内の投稿店舗一覧表示
    click_link 'マイページ'
    expect(page).to have_content 'テイクアウト店舗'
    expect(page).to have_content '〒194-8589'
    expect(page).to have_content '東京都町田市鶴間３丁目'
  end

  scenario '店舗情報を更新後、詳細画面と投稿店舗一覧にて反映を確認' do
    # データ作成
    @restaurant4 = FactoryBot.create(:edit_restaurant, registered_user_id: @user.id)

    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # 条件を入力して検索
    fill_in 'large-keyword', with: '神宮前'
    find('input#large-search').click

    # 検索画面の詳細ボタンを押下
    find('#detail-button').click

    # 詳細画面内の編集ボタンを押下
    click_link '編集'

    # 各項目を入力して更新
    attach_file 'file-input', "#{Rails.root}/spec/factories/image/rspec_restaurant.jpg"
    fill_in '店舗名', with: "テストラーメン屋"
    fill_in '郵便番号', with: "194-0000"
    fill_in '所在地', with: "東京都町田市鶴間４丁目"
    fill_in '電話番号', with: "042-777-0000"
    click_button '更新'

    # 店舗詳細画面表示
    expect(page).to have_selector '.restaurant-name-title', text: 'テストラーメン屋'
    expect(page).to have_selector '.detail-info-text', text: 'テストラーメン屋 基本情報'
    expect(page).to have_content '042-777-0000'
    expect(page).to have_content '〒194-0000 東京都町田市鶴間４丁目'
    expect(page).to_not have_content 'レビュー投稿は会員のみご利用できます。'
    expect(page).to_not have_content '会員登録はこちら'
    expect(page).to have_selector("img[src$='rspec_restaurant.jpg']")

    # マイページ内の投稿店舗一覧表示
    click_link 'マイページ'
    expect(page).to have_content 'テストラーメン屋'
    expect(page).to have_content '〒194-0000'
    expect(page).to have_content '東京都町田市鶴間４丁目'
  end

  scenario '登録された店舗を削除' do
    # データ作成
    @restaurant4 = FactoryBot.create(:edit_restaurant, registered_user_id: @user.id)

    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # 条件を入力して検索
    fill_in 'large-keyword', with: '神宮前'
    find('input#large-search').click

    # 検索画面の詳細ボタンを押下
    find('#detail-button').click

    # 詳細画面内の編集ボタンを押下
    click_link '店舗を削除する'

    # フラッシュメッセージ
    expect(page).to have_content '店舗情報の削除が完了しました'

    # マイページ内の投稿店舗一覧に無いことを確認
    click_link 'マイページ'
    expect(page).to_not have_content 'テスト店舗原宿'
    expect(page).to_not have_content '〒372-0851'
    expect(page).to_not have_content '東京都渋谷区神宮前1'
  end
end
