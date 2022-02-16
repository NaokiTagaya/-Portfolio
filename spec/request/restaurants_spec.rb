require 'rails_helper'

RSpec.describe 'Restaurants', type: :request, js: true do
  describe 'GET /restaurants/search' do
    it '検索一覧画面の表示に成功すること' do
      get restaurants_search_path
      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
  end
end