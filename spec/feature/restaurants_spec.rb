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
    click_button '検索'

    # コンテンツ表示
    expect(page).to have_content '検索結果：3件'
    expect(page).to have_content 'レストランRspec'
    expect(page).to have_content '東京都渋谷区渋谷２丁目'
    expect(page).to have_content 'Rspecレストラン'
    expect(page).to have_content '神奈川県横浜市西区みなとみらい２丁目３'
    expect(page).to have_content '群馬レストラン'
    expect(page).to have_content '群馬県伊勢崎市上蓮町６５７'
  end
end