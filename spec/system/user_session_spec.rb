require 'rails_helper'

RSpec.describe 'ユーザーログイン', type: :system do
  # Userモデル初期化
  before do
    User.destroy_all
  end

  context 'ユーザーログインができるとき' do
    # 正しいuser情報を作成
    let(:valid_user_info) do
      {
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }
    end

    it '正しい情報を入力すればユーザーログインができてトップページに移動する' do
    end

    it 'ログイン中にはユーザーログアウトができてトップページに移動する' do
    end
  end
end
