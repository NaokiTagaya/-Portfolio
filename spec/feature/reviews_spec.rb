require 'rails_helper'

RSpec.describe 'Review', type: :feature do
  before do
    @user = FactoryBot.create(:regi_user)
    @user1 = FactoryBot.create(:profile_user,)
    @restaurant1 = FactoryBot.create(:kanagawa_restaurant)
    @restaurant2 = FactoryBot.create(:gunma_restaurant)
    @four_rate = FactoryBot.create(:four_rate, restaurant_id: @restaurant1.id, user_id: @user.id)
    @two_point_five_rate = FactoryBot.create(:two_point_five_rate, restaurant_id: @restaurant2.id, user_id: @user.id)
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
    expect(page).to have_selector '.customer-rate-label', text: '4.0'
    expect(page).to have_content '1件のレビュー'
    expect(page).to have_selector("img[src$='default_icon.png']")
    expect(page).to have_content 'ポテパン次郎'
    expect(page).to have_content '4.0'
    expect(page).to have_content '評価は4点です。'
  end

  scenario 'マイページ内の投稿レビュー一覧を表示' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'jiro_potepan@test.com'
    fill_in 'パスワード', with: 'potepote1234'
    click_button 'ログイン'

    # マイページへ遷移
    click_link 'マイページ'

    # 投稿レビュー一覧コンテンツ表示
    expect(page).to have_selector '.post-rest-head', text: 'Rspecレストラン'
    expect(page).to have_content '4.0'
    expect(page).to have_content '評価は4点です。'
    expect(page).to have_link '店舗詳細', href: restaurant_path(@restaurant1.id)
    expect(page).to have_link 'レビューを削除', href: review_path(@four_rate.id)
    expect(page).to have_selector '.post-rest-head', text: '群馬レストラン'
    expect(page).to have_content '2.5'
    expect(page).to have_content '良くも悪くも2.5点ですね。'
    expect(page).to have_link '店舗詳細', href: restaurant_path(@restaurant2.id)
    expect(page).to have_link 'レビューを削除', href: review_path(@two_point_five_rate.id)
  end

  scenario 'レビュー投稿' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'profile@test.com'
    fill_in 'パスワード', with: 'hogohoge4567'
    click_button 'ログイン'

    # マイページへ遷移
    click_link 'マイページ'

    # まだレビューが未投稿であることを確認
    expect(page).to have_content '投稿したレビューはありません'

    # 検索後、詳細画面のレビュー投稿するボタンを押下
    visit root_url
    fill_in 'large-area', with: '群馬'
    find('input#large-search').click
    find('#detail-button').click
    click_link 'レビュー投稿する'

    # レビュー投稿画面にてレビューを投稿
    expect(page).to have_content 'レビュー投稿'
    expect(page).to have_selector("img[src$='no_image.jpg']")
    expect(page).to have_content '群馬レストラン'
    find('#review_star').find("img[alt$='5']").click
    fill_in 'コメント', with: 'とても良かったです！また利用したいと思います。'
    click_button '投稿する'

    # 店舗詳細画面内のレビュー一覧に反映されていることを確認
    expect(page).to have_content 'レビューを投稿しました'
    expect(page).to have_selector '.customer-rate-label', text: '5.0'
    expect(page).to have_content '1件のレビュー'
    expect(page).to have_selector("img[src$='default_icon.png']")
    expect(page).to have_content 'Rspecプロフィールユーザー'
    expect(page).to have_content '5.0'
    expect(page).to have_content 'とても良かったです！また利用したいと思います。'
    expect(page).to_not have_content '投稿したレビューはありません'

    # マイページ内のレビュー一覧にも反映されていることを確認
    click_link 'マイページ'
    expect(page).to have_selector '.post-rest-head', text: '群馬レストラン'
    expect(page).to have_content '5.0'
    expect(page).to have_content 'とても良かったです！また利用したいと思います。'
    expect(page).to have_link '店舗詳細', href: restaurant_path(@restaurant2.id)
    expect(page).to have_link 'レビューを削除', href: review_path
  end

  scenario 'レビュー削除' do
  end
end
