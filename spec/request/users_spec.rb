RSpec.describe 'POST /users', type: :request do
  context 'すべてのパラメータが揃っている場合' do
    it '200 OKを返す' do
      post '/users', params: { email: 'test@rspec.com', user_name: 'rspecテスト', sex: '1', age: '32', password: 'hogehoge', password_confirmation: 'hogehoge' }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(200)
    end

    it '接続に成功する' do
      post '/users', params: { email: 'test@rspec.com', user_name: 'rspecテスト', sex: '1', age: '32', password: 'hogehoge', password_confirmation: 'hogehoge' }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
    end

    it 'ユーザーを登録する' do
      expect do
        post '/users', params: { email: 'test@rspec.com', user_name: 'rspecテスト', sex: '1', age: '32', password: 'hogehoge', password_confirmation: 'hogehoge' }, headers: { 'ACCEPT' => 'application/json' }
       end.change(User, :count).by(1)
       expect(User.find_by(email: 'test@rspec.com')).to have_attributes(password: 'hogehoge')
      end
    end
  end

  context 'メールアドレスが不足している場合' do
    it '400 Bad Requestを返す' do
      post '/users', params: { email: '', user_name: 'rspecテスト', sex: '1', age: '32', password: 'hogehoge', password_confirmation: 'hogehoge' }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(400)
    end
  end
end