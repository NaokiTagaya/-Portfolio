# フジノキとは

フジノキはポテパンキャンプ様にてカリキュラムを学んだ後、ポートフォリオとして作成したものです。
ユーザーがテイクアウトの店舗をサイトに登録し、他のユーザに共有することができます。
また、登録された店舗に対してレビューを付けることができたり、気に入った店舗があればお気に入りに追加することができます。
![site_image](https://user-images.githubusercontent.com/79247499/153329294-180073c7-7e26-4d60-82ef-530dfe59cc20.png)

# 機能一覧

* ユーザー登録、ログイン機能(devise)
* マイページ閲覧機能
  * ユーザー情報閲覧機能
  * お気に入り一覧機能
  * 投稿レビュー一覧機能
  * 投稿店舗一覧機能
* ユーザープロフィール編集機能(devise)
  * ユーザー画像プレビュー機能(Vue)
  * ユーザー画像アップロード機能(carrirewave)
* 店舗検索機能
* 店舗投稿機能
  * 店舗画像プレビュー機能(Vue)
  * 店舗画像アップロード機能(carrierwave)
* 店舗詳細閲覧機能
  * 店舗所在地機能(geocoder)
* レビュー投稿機能
  * 星評価機能(jQuery Raty)
* お気に入り機能(Ajax)

# テスト

* Rspec
  * 単体テスト(model)
  * 機能テスト(request)
  * 統合テスト(feature)


# 要件

* 使用技術
  * Ruby 2.7.0
  * Rails 5.2.6
  * webpacker 5.4.3
  * mysql2 0.5.3
  * jquery-rails 4.4.0
  * bootstrap 4.3.1
  * carrierwave 2.2.2
  * devise 4.8.0
  * geocoder 1.7.2

* 開発環境
  * MacOS Monterey バージョン12.1
  * Docker Version 4.4.2
  * Visual Studio Code 1.63.2 (Universal)

# 閲覧方法

1. 下記URLへアクセスしてください。

2. 新規登録していただくか、もしくは以下メールアドレス・パスワードを使用してログインしてください。<br>
  * メールアドレス：potepan@test.com
  * パスワード：potepantaro225

# ノート

* パスワードは半角英数字6文字以上で入力してください。
* マイページと店舗詳細画面内のタブ切り替え機能はVueにて作成しております。

# 著者

* 多賀谷直樹
* ポテパンキャンプ
* Mail：nao.tagaya.k05@gmail.com