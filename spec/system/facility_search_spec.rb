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

  it '既存の施設名を入力すれば施設を検索できる' do
  end

  it '存在しない施設名を入力すれば「お探しの施設はありません」と表示される' do
  end

  it '検索結果に関わらず、一覧表示には常にすべての施設が表示される' do
  end
end
