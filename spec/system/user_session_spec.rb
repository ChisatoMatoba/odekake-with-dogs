require 'rails_helper'

RSpec.describe 'ユーザーログイン', type: :system do
  # ログインテスト用のユーザーを作成
  let(:user) { FactoryBot.create(:user) }

  it '正しい情報を入力すればユーザーログインができてトップページに移動する' do
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    # ログインボタンを押す
    find('input[name="commit"]').click

    # トップページへ遷移することを確認する
    expect(page).to have_current_path(root_path)
    # ログアウトボタンが表示されることを確認する
    expect(page).to have_content('ログアウト')
    # ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_link('ログイン', href: new_user_session_path)
    # サインアップページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('会員登録')
  end

  it 'ログイン中にはユーザーログアウトができてトップページに移動する' do
    # ログイン処理を行う
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # ログアウトボタンをクリックする
    click_on 'ログアウト'
    # トップページへ遷移することを確認する
    expect(page).to have_current_path(root_path)
    # ログインページへ遷移するボタンとサインアップページへ遷移するボタンが表示されていることを確認する
    expect(page).to have_link('ログイン', href: new_user_session_path)
    expect(page).to have_content('会員登録')
  end
end
