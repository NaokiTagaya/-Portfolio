require 'rails_helper'

RSpec.describe 'User', type: :feature do
  scenario "ユーザー登録を行う" do
    visit root_path

    click_link "新規登録"
  end
end