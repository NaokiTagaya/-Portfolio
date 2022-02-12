require 'rails_helper'

RSpec.describe 'User_model', type: :model do
  describe 'userモデル必須チェック' do
    it '必須パラメータを全て入力し、有効である' do
      expect(FactoryBot.create(:user)).to be_valid
    end
  end
end