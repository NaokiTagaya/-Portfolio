RSpec.describe 'Users', type: :request, js: true do
  describe 'POST #create' do
    let(:test_user) { FactoryBot.create :test_user }

    context 'すべてのパラメータが揃っている場合' do
      it '200 OKを返すこと' do
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

      it 'リダイレクトされること' do
        post user_registration_path, params: { id: test_user }
        expect(response).to redirect_to users_path
      end
    end
  end
end
