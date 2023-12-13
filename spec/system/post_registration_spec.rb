require 'rails_helper'

RSpec.describe '施設新規登録', type: :system do
  # テスト用のユーザーを作成
  let!(:user) { FactoryBot.create(:user) }
  # テスト用の施設を作成
  let!(:facility) { FactoryBot.create(:facility, user: user, place_name: 'テスト施設') }

  before do
    # 事前にサインインしておく
    sign_in user
  end

  it '施設詳細画面から新規投稿画面に遷移後、その施設の情報が表示される' do

  end

  it '正しい情報を入力すれば投稿でき、投稿詳細画面に移動する' do

  end
end
