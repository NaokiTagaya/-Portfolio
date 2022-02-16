require 'rails_helper'

RSpec.describe 'Users', type: :request, js: true do
  
  describe 'GET /users/sign_up' do
    it '会員登録画面の表示に成功すること' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    let(:test_user) { FactoryBot.create :test_user }
    let(:fail_user) { attributes_for(:user, user_name: "") }
    context 'すべてのパラメータが揃っている場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { id: test_user }
        expect(response).to have_http_status(200)
      end

      it '接続に成功すること' do
        post user_registration_path, params: { id: test_user }
        expect(response).to be_successful
      end

      it 'ユーザー登録が成功すること' do
        expect do
          post user_registration_path, params: { id: test_user }
        end.to change(User, :count).by 1
      end
    end

    context 'パラメータにユーザー名が無い場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { id: fail_user }
        expect(response).to have_http_status(200)
      end

      it 'ユーザー登録が失敗すること' do
        expect do
          post user_registration_path, params: { id: fail_user }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        post user_registration_path, params: { id: fail_user }
        expect(response.body).to include '名前を入力してください'
      end
    end
  end

  describe 'GET /users/sign_in' do
    it 'ログイン画面の表示に成功すること' do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /users/sign_in' do
    let(:login_user) { FactoryBot.create :login_user }
    context '登録されたユーザー' do
      it 'ログインに成功すること' do
        sign_in login_user
        post user_session_path
        expect(response.status).to eq 302
      end
    end
  end

  describe 'GET /users/profile' do
    it 'プロフィール詳細画面の表示に成功すること' do
      profile_user = FactoryBot.create(:profile_user)
      get users_profile_path, params: { id: profile_user, registered_user_id: profile_user.id, user_id: profile_user.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/edit' do
    let(:profile_user) { FactoryBot.create :profile_user }
    let(:restaurant) { FactoryBot.create :restaurant }
    it 'プロフィール編集画面の表示に成功すること' do
      get edit_user_registration_path, params:  { id: profile_user, registered_user_id: profile_user, user_id: profile_user }
      expect(response).to have_http_status(200)
    end
  end
end
