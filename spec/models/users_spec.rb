require 'rails_helper'

RSpec.describe 'User_model', type: :model do
  describe 'userモデル処理チェック' do
    context '正常ケース' do
      it '必須パラメータを全て入力し、登録できる' do
        expect(FactoryBot.create(:user)).to be_valid
      end
    end

    context '未入力チェック' do
      it 'ユーザ名が未入力の場合、登録できない' do
        expect(FactoryBot.build(:user, user_name: "")).to_not be_valid
      end

      it '年齢が未入力の場合、登録できない' do
        expect(FactoryBot.build(:user, age: "")).to_not be_valid
      end

      it 'メールアドレスが未入力の場合、登録できない' do
        expect(FactoryBot.build(:user, email: "")).to_not be_valid
      end

      it 'パスワードが未入力の場合、登録できない' do
        expect(FactoryBot.build(:user, password: "")).to_not be_valid
      end

      it 'パスワード（確認用）が未入力の場合、登録できない' do
        expect(FactoryBot.build(:user, password_confirmation: "")).to_not be_valid
      end

    end

    context 'モデルのバリデーションチェック' do
      it 'ユーザー名が30文字以上の場合、登録できない' do
        expect(FactoryBot.build(:user, user_name: "テスト12345678901234567890123456789")).to_not be_valid
      end

      it '年齢が数字以外の場合、登録できない' do
        expect(FactoryBot.build(:user, age: "てす")).to_not be_valid
      end

      it 'メールアドレスがフォーマット通りでない場合、登録できない' do
        user1 = FactoryBot.build(name: "taro", email: "taro@example.com")
        except(FactoryBot.build(:user, name: "ziro", email: user1.email)).to_not be_valid
      end

      it 'メールアドレスが重複していた場合、登録できない' do
        expect(FactoryBot.build(:user, email: "testaiueo")).to_not be_valid
      end

      it 'パスワードが6文字以下の場合、登録できない' do
        expect(FactoryBot.build(:user, password: "test1")).to_not be_valid
      end

      it 'パスワードが数字のみの場合、登録できない' do
        expect(FactoryBot.build(:user, password: "1234567")).to_not be_valid
      end

      it 'パスワードが半角英字のみの場合、登録できない' do
        expect(FactoryBot.build(:user, password: "abcdefg")).to_not be_valid
      end

      it 'パスワードとパスワード（確認用）が一致しない場合、登録できない' do
        expect(FactoryBot.build(:user,password:"password",password_confirmation: "passward")).to_not be_valid 
      end
    end
  end
end