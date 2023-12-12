require 'rails_helper'

RSpec.describe '施設新規登録', type: :system do
  before do
    # テスト用のユーザーを作成
    @user = FactoryBot.create(:user)
  end

  it '正しい情報を入力すれば施設を登録できて、施設詳細画面に移動する' do

  end

  private

end
