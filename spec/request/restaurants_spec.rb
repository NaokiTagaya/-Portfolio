require 'rails_helper'

RSpec.describe 'Restaurants', type: :request, js: true do
  describe 'GET /restaurants/search' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    
    it '検索一覧画面の表示に成功すること' do
      get restaurants_search_path
      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
  end

  describe 'GET /restaurants/new' do
    it '店舗登録画面の表示に成功すること' do
      get new_restaurant_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    let(:restaurant) { FactoryBot.create :restaurant }
    let(:fail_restaurant) { attributes_for(:restaurant, restaurant_name: "") }
    context 'すべてのパラメータが揃っている場合' do
      it 'リクエストが成功すること' do
        post restaurants_path, params: { id: restaurant }
        expect(response).to have_http_status(200)
      end

      it '接続に成功すること' do
        post restaurants_path, params: { id: restaurant }
        expect(response).to be_successful
      end

      it '店舗登録が成功すること' do
        expect do
          post restaurants_path, params: { id: restaurant }
        end.to change(Restaurant, :count).by 1
      end
    end
  end
end
