require 'rails_helper'

RSpec.describe '施設新規登録', type: :system do
  # テスト用のユーザーを作成
  let!(:user) { FactoryBot.create(:user) }

  it '正しい情報を入力すれば施設を登録できて、施設詳細画面に移動する' do
    # ログイン処理を行う
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
  end
end
