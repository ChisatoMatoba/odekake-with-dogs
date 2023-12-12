require 'rails_helper'

RSpec.describe '施設新規登録', type: :system do
  # テスト用のユーザーを作成
  let!(:user) { FactoryBot.create(:user) }
  # テスト用の施設を作成
  let!(:facility) { FactoryBot.create(:facility) }

  before do
    # 事前にサインインしておく
    sign_in user
  end

  it '正しい情報を入力すれば施設を登録できて、施設詳細画面に移動する' do
  end
end
