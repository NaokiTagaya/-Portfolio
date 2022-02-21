require 'rails_helper'

RSpec.describe 'Restaurant', type: :feature do
  before do
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
    expect(page).to have_content 'Rspecレストラン'
    expect(page).to have_content 'Rspecレストラン 基本情報'
    expect(page).to have_content '03-1234-5678'
    expect(page).to have_content '〒150-0000 東京都渋谷区渋谷２丁目'
    expect(page).to have_content 'レビュー投稿は会員のみご利用できます。'
    expect(page).to have_content '会員登録はこちら'
    expect(page).to_not have_content 'お気に入り登録'
  end

  scenario 'ログイン時の店舗詳細画面表示' do
    # ログイン処理
    @user = FactoryBot.create(:regi_user)
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
    expect(page).to have_content 'レストランRspec'
    expect(page).to have_content 'レストランRspec 基本情報'
    expect(page).to have_content '03-1234-5678'
    expect(page).to have_content '〒150-0000 東京都渋谷区渋谷２丁目'
    expect(page).to_not have_content 'レビュー投稿は会員のみご利用できます。'
    expect(page).to_not have_content '会員登録はこちら'
    expect(page).to have_content 'お気に入り登録'
  end
end
