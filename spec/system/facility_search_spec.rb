require 'rails_helper'

RSpec.describe '施設検索', type: :system do
  # テスト用のユーザーを作成
  let!(:user) { FactoryBot.create(:user) }
  # テスト用の施設を作成
  let!(:facility) { FactoryBot.create(:facility, user: user, place_name: 'テスト施設') }
  let!(:facility_hokkaido) { FactoryBot.create(:facility, user: user, prefecture: '北海道') }

  before do
    # 事前にサインインしておく
    sign_in user
    # 施設一覧画面へ遷移する
    visit facilities_path
  end

  it '既存の施設名を入力すれば施設を検索でき、施設詳細へ遷移できる' do
    # 検索フォームに入力する
    fill_in '施設名', with: 'テスト施設'
    click_on '検索'
    # 検索結果欄と検索結果が表示されることを確認する
    expect(page).to have_content '検索結果'
    expect(page).to have_content 'テスト施設'
    # 施設名をクリックする
    click_on 'テスト施設'
    # テスト施設の詳細画面へ遷移することを確認する
    expect(page).to have_current_path(facility_path(facility))
    # クリックした施設名がページに表示されていることを確認
    expect(page).to have_text('テスト施設')
  end

  it '存在しない施設名を入力すれば「お探しの施設はありません」と表示される' do
  end

  it '検索結果に関わらず、一覧表示には常にすべての施設が表示される' do
  end
end
