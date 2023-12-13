require 'rails_helper'

RSpec.describe '施設検索', type: :system do
  # テスト用のユーザーを作成
  let!(:user) { FactoryBot.create(:user) }
  # テスト用の施設を作成
  let!(:facility) { FactoryBot.create(:facility, user: user, place_name: 'テスト施設') }

  before do
    # 事前にサインインしておく
    sign_in user
  end

  it '既存の施設名を入力すれば施設を検索できる' do
  end

  it '存在しない施設名を入力すれば「お探しの施設はありません」と表示される' do
  end
end
