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
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    it '店舗登録画面の表示に成功すること' do
      get new_restaurant_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let(:input) { ActionController::Parameters.new(restaurant: param_restaurant) }
    let(:param_restaurant) { { restaurant_name: 'レストランRspec', tel: '03-1234-5678', zipcode: '150-0000', address: '東京都渋谷区渋谷２丁目', registered_user_id: 1 } }
    context 'すべてのパラメータが揃っている場合' do
      it 'リクエストが成功すること' do
        post restaurants_path, params: { id: input }
        expect(response).to have_http_status(200)
      end

      it '接続に成功すること' do
        post restaurants_path, params: { id: input }
        expect(response).to be_successful
      end

      it '店舗登録が成功すること' do
        expect do
          post restaurants_path, params: { id: input }
        end.to change(Restaurant, :count).by 1
      end
    end
  end
end
