require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, user_name: "Rspecテスト", sex: "1", age: "32", email: "test@rspec.com", password: "hogehoge1234") }
  
  describe 'userモデル必須チェック' do
    it '必須パラメータを全て入力し、有効である' do
      expect(user).to be_valid
    end
  end
end