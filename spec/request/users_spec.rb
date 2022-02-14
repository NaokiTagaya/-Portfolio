RSpec.describe 'Users', type: :request, js: true do
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

  describe 'GET #show' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    it 'リクエストが成功すること' do
      expect(response).to have_http_status(200)
    end
  end
end
