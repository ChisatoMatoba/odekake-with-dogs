require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  # Userモデル初期化
  before do
    User.destroy_all
  end

  context 'ユーザー新規登録ができるとき' do
    # 正しいuser情報を作成
    let(:valid_user_info) do
      {
        nickname: 'テストユーザー',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        birthday: '2000-01-01'
      }
    end

    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # 新規登録ページへ移動する
      move_to_registration
      # ユーザー情報を入力する
      fill_in_user_info(valid_user_info)
      # サインアップボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移したことを確認する
      expect(page).to have_current_path(root_path)
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      # ユーザーモデルのカウントが1上がることを確認する
      expect(User.count).to eq 1
    end
  end

  context 'ユーザー新規登録ができないとき' do
    # 誤ったuser情報を作成
    let(:invalid_user_info) do
      {
        nickname: '',
        email: '',
        password: 'pass',
        password_confirmation: 'password',
        birthday: ''
      }
    end

    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # 新規登録ページへ移動する
      move_to_registration
      # ユーザー情報を入力する
      fill_in_user_info(invalid_user_info)
      # サインアップボタンを押す
      find('input[name="commit"]').click
      # 新規登録ページへ戻されることを確認する
      expect(page).to have_current_path(new_user_registration_path)
      # ユーザーモデルのカウントが上がっていないことを確認する
      expect(User.count).to eq 0
    end
  end

  private

  def move_to_registration
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('会員登録')
    # 新規登録ページへ移動する
    visit new_user_registration_path
  end

  def fill_in_user_info(user)
    # ユーザー情報を入力する
    fill_in 'nickname', with: user[:nickname]
    fill_in 'email', with: user[:email]
    fill_in 'password', with: user[:password]
    fill_in 'password-confirmation', with: user[:password_confirmation]
    # 生年月日が有効な場合のみ入力する
    return if user[:birthday].blank?

    birthday = Date.parse(user[:birthday])
    select birthday.year.to_s, from: 'user_birthday_1i' # 年
    select birthday.month.to_s, from: 'user_birthday_2i' # 月
    select birthday.day.to_s, from: 'user_birthday_3i' # 日
  end
end
