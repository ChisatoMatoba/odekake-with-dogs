require 'rails_helper'

RSpec.describe Dog, type: :model do
  before do
    @dog = FactoryBot.build(:dog)
  end

  describe '愛犬登録' do
    context '愛犬登録ができる場合' do
      it 'すべての入力内容とimageが存在していれば保存できる' do
        expect(@dog).to be_valid
      end
    end

    context '愛犬登録ができない場合' do
      it '画像が選択されていなければ保存できない' do
      end
    end
  end
end
