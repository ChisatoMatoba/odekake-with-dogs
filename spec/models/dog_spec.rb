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
        @dog.image = nil
        @dog.valid?
        expect(@dog.errors.full_messages).to include("わんちゃんの画像を入力してください")
      end
      it '名前が空では保存できない' do
        @dog.dog_name = ''
        @dog.valid?
        expect(@dog.errors.full_messages).to include("わんちゃんのお名前を入力してください")
      end
      it '生年月日が---では保存できない' do
        @dog.dog_birthday = ''
        @dog.valid?
        expect(@dog.errors.full_messages).to include("わんちゃんの生年月日を入力してください")
      end
      it '犬種が---では保存できない' do
        @dog.breed_id = Breed.find_by(name: '---').id
        @dog.valid?
        expect(@dog.errors.full_messages).to include("わんちゃんの犬種を入力してください")
      end
      it '性別が---では保存できない' do
        @dog.gender_id = Gender.find_by(name: '---').id
        @dog.valid?
        expect(@dog.errors.full_messages).to include("わんちゃんの性別を入力してください")
      end
    end
  end
end
