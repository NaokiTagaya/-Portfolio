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
      @user = FactoryBot.create(:login_user)
      sign_in @user
    end

    let(:create_restaurant) { FactoryBot.build(:restaurant) }
    let(:param_restaurant) { { restaurant_name: create_restaurant.restaurant_name, tel: create_restaurant.tel, zipcode: create_restaurant.zipcode, address: create_restaurant.address, registered_user_id: create_restaurant.registered_user_id } }
    context 'すべてのパラメータが揃っている場合' do
      it 'リクエストが成功すること' do
        post restaurants_path, params: { restaurant: param_restaurant }
        expect(response).to have_http_status(:ok)
      end

      it '店舗登録が成功すること' do
        expect do
          post restaurants_path, params: { restaurant: param_restaurant }
        end.to change(Restaurant, :count).by 1
      end
    end
  end

  describe 'GET /restaurants/:id/edit' do
    before do
      @user = FactoryBot.create(:login_user)
      sign_in @user
    end

    let(:restaurant) { FactoryBot.create :restaurant }
    it '店舗編集画面の表示に成功すること' do
      get edit_restaurant_path(id: restaurant)
      expect(response).to have_http_status(:ok)
    end
  end
end
