require 'rails_helper'

RSpec.describe 'Restaurant_model', type: :model do
  describe 'restaurantモデル処理チェック' do
    context '正常ケースチェック' do
      it '必須パラメータを全て入力し、登録できる' do
        expect(FactoryBot.create(:restaurant)).to be_valid
      end
    end

    context '未入力チェック' do
      it '店舗名が未入力の場合、登録できない' do
        expect(FactoryBot.build(:restaurant, restaurant_name: "")).to_not be_valid
      end

      it '電話番号が未入力の場合、登録できない' do
        expect(FactoryBot.build(:restaurant, tel: "")).to_not be_valid
      end

      it '郵便番号が未入力の場合、登録できない' do
        expect(FactoryBot.build(:restaurant, zipcode: "")).to_not be_valid
      end

      it '店舗所在地が未入力の場合、登録できない' do
        expect(FactoryBot.build(:restaurant, address: "")).to_not be_valid
      end
    end

    context 'モデルのバリデーションチェック' do
      it '電話番号がフォーマット通りでない場合、登録できない' do
        expect(FactoryBot.build(:restaurant, tel: "123456")).to_not be_valid
      end

      it '郵便番号がフォーマット通りでない場合、登録できない' do
        expect(FactoryBot.build(:restaurant, tel: "12345")).to_not be_valid
      end
    end
  end
end
