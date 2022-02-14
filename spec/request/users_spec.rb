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
    let(:req_params) { { session_form: { email: "rspeclogin@test.com", password: input_pass } } }
    context '登録されたユーザー' do
      let(:input_pass) { "hogohoge1234" }
      it 'ログインに成功すること' do
        post session_path, params: req_params
        expect(response).to redirect_to root_path
      end
    end
    context '未登録のユーザー' do
      let(:input_pass) { "hogohoge5678" }
      it 'ログインに失敗すること' do
        post session_path, params: req_params
        expect(response.body).to include '失敗しました。'
      end
    end
  end
end
