require 'rails_helper'

RSpec.describe 'User', type: :feature do
  scenario 'ログイン前のトップページ表示' do
    # トップページ
    visit root_url

    # コンテンツ表示
    expect(page).to have_link 'ホーム', href: root_path
    expect(page).to have_link 'ログイン', href: new_user_session_path
    expect(page).to have_link '新規登録', href: new_user_registration_path
    expect(page).to have_link '今すぐ登録', href: new_user_registration_path
  end

  scenario 'ログイン後のトップページ表示' do
    # ログイン処理
    @user = FactoryBot.create(:regi_user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # コンテンツ表示
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_link 'ホーム', href: root_path
    expect(page).to have_link 'マイページ', href: users_profile_path
    expect(page).to have_link '店舗登録', href: new_restaurant_path
    expect(page).to have_link 'ログアウト', href: destroy_user_session_path
    expect(page).to have_selector '.navbar-user-name', text: 'ポテパン次郎'
    expect(page).to have_selector("img[src$='default_icon.png']")
    expect(page).to_not have_link '今すぐ登録', href: new_user_registration_path
  end

  scenario '会員登録後、マイページ表示' do
    # トップページ遷移後、新規登録ボタンをクリック
    visit root_url
    click_link '新規登録'

    # ユーザー情報を入力して登録する
    fill_in '名前', with: "テスト太郎"
    fill_in '年齢', with: 30
    choose "user_sex_male"
    fill_in 'メールアドレス', with: 'taro_test@rspec.com'
    fill_in 'パスワード（半角英数字6文字以上）', with: 'rspectest1234'
    fill_in 'パスワード（確認用）', with: 'rspectest1234'
    click_button 'アカウント登録'

    # コンテンツ表示（ナビゲーションバー）
    expect(page).to have_link 'ホーム', href: root_path
    expect(page).to have_link 'マイページ', href: users_profile_path
    expect(page).to have_link '店舗登録', href: new_restaurant_path
    expect(page).to have_link 'ログアウト', href: destroy_user_session_path
    expect(page).to have_selector '.navbar-user-name', text: 'テスト太郎'
    expect(page).to have_selector("img[src$='default_icon.png']")

    # コンテンツ表示（マイページ）
    expect(page).to have_content 'テスト太郎'
    expect(page).to have_content '30'
    expect(page).to have_content '男性'
    expect(page).to have_content 'taro_test@rspec.com'
  end

  scenario 'プロフィールを更新' do
    # ログイン処理
    @user = FactoryBot.create(:regi_user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # マイページへ遷移
    click_link 'マイページ'

    # プロフィール編集画面へ遷移
    click_link 'プロフィール編集'

    # 項目をそれぞれ入力して更新
    fill_in '名前', with: "テスト花子"
    fill_in '年齢', with: 31
    choose "user_sex_female"
    fill_in 'メールアドレス', with: 'hanako_test@rspec.com'
    fill_in '新しいパスワード（半角英数字6文字以上）', with: 'rspectest6789'
    fill_in '新しいパスワード（確認用）', with: 'rspectest6789'
    attach_file 'file-input', "#{Rails.root}/spec/factories/image/image.png"
    click_button '更新'

    # コンテンツ表示（マイページ）
    expect(page).to have_content 'テスト花子'
    expect(page).to have_content '31'
    expect(page).to have_content '女性'
    expect(page).to have_content 'hanako_test@rspec.com'
    expect(page).to have_selector("img[src$='image.png']")

    # コンテンツ表示（ナビゲーションバー）
    expect(page).to have_selector '.navbar-user-name', text: 'テスト花子'
    expect(page).to have_selector("img[src$='image.png']")
  end
end
