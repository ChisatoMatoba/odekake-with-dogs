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
    # ログインボタンを押す(rootへ移動)
    find('input[name="commit"]').click

    # 施設一覧・新規投稿ボタンが表示されることを確認する
    expect(page).to have_content('施設一覧・新規投稿')
    # 施設一覧・新規投稿ボタンをクリックする
    click_on '施設一覧・新規投稿'
    # 施設一覧ページへ遷移することを確認する
    expect(page).to have_current_path(facilities_path)
    # 施設登録画面へボタンをクリックする
    click_on '施設登録画面へ'

    # 施設登録ページへ遷移することを確認する
    expect(page).to have_current_path(new_facility_path)
    # 施設情報を入力する
    select '北海道', from: 'prefecture'
    fill_in 'item-name', with: 'テスト施設'
    select '宿泊', from: 'item-category'
    # 登録ボタンを押す
    find('input[name="commit"]').click

    # その施設の詳細ページへ遷移することを確認する
    new_facility = Facility.last
    expect(page).to have_current_path(facility_path(new_facility))
    # 登録した施設名がページに表示されていることを確認
    expect(page).to have_text('テスト施設')
  end
end
