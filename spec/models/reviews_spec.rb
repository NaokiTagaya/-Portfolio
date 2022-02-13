require 'rails_helper'

RSpec.describe 'Review_model', type: :model do
  describe 'reviewモデル処理チェック' do
    context '正常ケースチェック' do
      it '必須パラメータを全て入力し、登録できる' do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant)
        expect(FactoryBot.build(:review, user_id: user.id, restaurant_id: restaurant.id).to be_valid
      end
    end

    context '未入力チェック' do
      it '評価が未入力の場合、登録できない' do
        expect(FactoryBot.build(:review, rate: "")).to_not be_valid
      end
    end

    context 'モデルのバリデーションチェック' do
      it '評価が0の場合、登録できない' do
        expect(FactoryBot.build(:review, rate: 0)).to_not be_valid
      end

      it '評価が6の場合、登録できない' do
        expect(FactoryBot.build(:review, rate: 6)).to_not be_valid
      end

      it '評価が数字でない場合、登録できない' do
        expect(FactoryBot.build(:review, rate: "あ")).to_not be_valid
      end
    end
  end
end
