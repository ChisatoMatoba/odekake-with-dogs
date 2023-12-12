require 'rails_helper'

RSpec.describe 'ユーザーログイン', type: :system do
  before do
    # ログインテスト用のユーザーを作成
    sign_in_user
  end

  it '正しい情報を入力すればユーザーログインができてトップページに移動する' do
    # トップページに移動する
    visit root_path
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
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
    visit root_path
    # ログイン処理を行う
    if page.has_content?('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: 'test@example.com'
      fill_in 'password', with: 'password123'
      # ログインボタンを押す
      find('input[name="commit"]').click
    end
    # ログアウトボタンをクリックする
    click_on 'ログアウト'
    # トップページへ遷移することを確認する
    expect(page).to have_current_path(root_path)
    # ログインページへ遷移するボタンとサインアップページへ遷移するボタンが表示されていることを確認する
    expect(page).to have_link('ログイン', href: new_user_session_path)
    expect(page).to have_content('会員登録')
  end

  private

  def sign_in_user
    # ユーザー情報をデータベースに保存する
    User.create!(nickname: 'テストユーザー', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', birthday: '2000-01-01')
    # root_pathに移動する
    visit root_path
    # ログアウトボタンが存在する場合、クリックしてログアウトする
    click_on 'ログアウト' if page.has_content?('ログアウト')
    # ログアウトしたことを確認する
    expect(page).to have_link('ログイン', href: new_user_session_path)
  end
end
