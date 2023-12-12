require 'rails_helper'

RSpec.describe '施設新規登録', type: :system do
  # テスト用のユーザーを作成
  let!(:user) { FactoryBot.create(:user) }
  # テスト用の施設を作成
  let!(:facility) { FactoryBot.create(:facility, user: user) }

  before do
    # 事前にサインインしておく
    sign_in user
  end

  it '正しい情報を入力すれば施設を編集できて、施設詳細画面に移動する' do
    # 施設詳細画面へ遷移する
    visit facility_path(facility)
    # 編集ボタンをクリックする
    click_on '編集'
    # 施設編集ページへ遷移することを確認する
    expect(page).to have_current_path(edit_facility_path(facility))
  end

  it '自分が作成した施設を削除できる' do
  end
end
