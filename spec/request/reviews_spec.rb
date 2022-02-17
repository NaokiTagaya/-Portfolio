require 'rails_helper'

RSpec.describe 'Reviews', type: :request, js: true do
  describe 'GET /reviews/new' do
    before do
      @restaurant = FactoryBot.create(:restaurant)
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    it 'レビュー投稿画面の表示に成功すること' do
      get new_review_path, params: { id: @restaurant.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    before do
      @restaurant = FactoryBot.create(:restaurant)
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let(:test_review) { FactoryBot.build(:review) }
    let!(:param_review) { { restaurant_id: @restaurant.id, user_id: @user.id, comment: test_review.comment, rate: test_review.rate } }
    it 'レビュー投稿画面の表示に成功すること' do
      post reviews_path, params: { review: param_review }
      expect(response).to have_http_status(200)
    end
  end
end