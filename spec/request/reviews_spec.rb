require 'rails_helper'

RSpec.describe 'Reviews', type: :request, js: true do
  describe 'GET /reviews/new' do
    it 'レビュー投稿画面の表示に成功すること' do
      get new_review_path
      expect(response).to have_http_status(200)
    end
  end
end