RSpec.describe 'Users', type: :request do
  describe 'POST #create' do
    context 'すべてのパラメータが揃っている場合' do
      it '200 OKを返すこと' do
        post registration_path, params: { user_name: 'Rspecユーザー', age: 32, sex: 1, email: 'rspec@test.com', password: 'hogohoge1234', password_confirmation: 'hogehoge1234' }
        expect(response).to have_http_status(200)
      end

      it '接続に成功すること' do
        post registration_path, params: { user_name: 'Rspecユーザー', age: 32, sex: 1, email: 'rspec@test.com', password: 'hogohoge1234', password_confirmation: 'hogehoge1234' }
        expect(response).to be_successful
      end

      it 'ユーザー登録が成功すること' do
        except do
          post registration_path, params: { user_name: 'Rspecユーザー', age: 32, sex: 1, email: 'rspec@test.com', password: 'hogohoge1234', password_confirmation: 'hogehoge1234' }
        end.to change(User, :count).by 1
      end

      it 'リダイレクトされること' do
        post registration_path, params: { user_name: 'Rspecユーザー', age: 32, sex: 1, email: 'rspec@test.com', password: 'hogohoge1234', password_confirmation: 'hogehoge1234' }
        expect(response).to redirect_to users_profile_path
      end
    end
  end
end
