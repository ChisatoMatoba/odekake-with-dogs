require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  def move_to_registration
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('会員登録')
    # 新規登録ページへ移動する
    visit new_user_registration_path
  end

  def user_count_expect(countby)
    # サインアップボタンを押すとユーザーモデルのカウントがcountby上がることを確認する
    expect do
      find('input[name="commit"]').click
      sleep 1
    end.to change(User, :count).by(countby)
  end

  def fill_in_user_info(user)
    # ユーザー情報を入力する
    fill_in 'nickname', with: user.nickname
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password-confirmation', with: user.password_confirmation
    # 生年月日を入力する
    select user.birthday.year.to_s, from: 'user_birthday_1i' # 年
    select user.birthday.month.to_s, from: 'user_birthday_2i' # 月
    select user.birthday.day.to_s, from: 'user_birthday_3i' # 日
  end

  context 'ユーザー新規登録ができるとき' do
    # 正しいuser情報を作成
    let(:user) { FactoryBot.build(:user) }

    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # 新規登録ページへ移動する
      move_to_registration
      # ユーザー情報を入力する
      fill_in_user_info(user)
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      user_count_expect(1)
      # トップページへ遷移したことを確認する
      expect(page).to have_current_path(root_path)
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    # 誤ったuser情報を作成
    let(:user) { FactoryBot.build(:user, email: nil) }

    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # 新規登録ページへ移動する
      move_to_registration
      # ユーザー情報を入力する
      fill_in_user_info(user)
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      user_count_expect(0)
      # 新規登録ページへ戻されることを確認する
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end