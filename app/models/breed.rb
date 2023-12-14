class Breed < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 2, name: 'その他 小型犬' },
    { id: 3, name: 'その他 中型犬' },
    { id: 4, name: 'その他 大型犬' },
    { id: 5, name: '秋田犬' },
    { id: 6, name: 'アメリカンコッカースパニエル' },
    { id: 7, name: 'イタリアングレーハウンド' },
    { id: 8, name: 'イングリッシュコッカースパニエル' },
    { id: 9, name: 'ウィペット' },
    { id: 10, name: '甲斐犬' },
    { id: 11, name: 'カニンヘンダックスフンド' },
    { id: 12, name: '紀州犬' },
    { id: 13, name: 'キャバリア' },
    { id: 14, name: 'キングチャールズスパニエル' },
    { id: 15, name: 'グレイハウンド' },
    { id: 16, name: 'グレートピレニーズ' },
    { id: 17, name: 'コーギー(ウェルシュコーギーカーディガン)' },
    { id: 18, name: 'コーギー(ウェルシュコーギーペンブローク)' },
    { id: 19, name: 'ゴールデンレトリバー' },
    { id: 20, name: 'シーズー' },
    { id: 21, name: 'シェットランドシープドッグ' },
    { id: 22, name: 'シェパード種' },
    { id: 23, name: '柴犬' },
    { id: 24, name: 'シベリアンハスキー' },
    { id: 25, name: 'ジャックラッセルテリア' },
    { id: 26, name: 'スタンダードプードル' },
    { id: 27, name: 'ダルメシアン' },
    { id: 28, name: 'チワワ' },
    { id: 29, name: '狆' },
    { id: 30, name: 'トイプードル' },
    { id: 31, name: '土佐犬' },
    { id: 32, name: '日本スピッツ' },
    { id: 33, name: 'ニューファンドランド' },
    { id: 34, name: 'バーニーズマウンテンドッグ' },
    { id: 35, name: 'パグ' },
    { id: 36, name: 'パピヨン' },
    { id: 37, name: 'ビーグル' },
    { id: 38, name: 'ビションフリーゼ' },
    { id: 39, name: 'ブルドッグ' },
    { id: 40, name: 'フレンチブルドッグ' },
    { id: 41, name: 'ペキニーズ' },
    { id: 42, name: 'ボーダーコリー' },
    { id: 43, name: 'ボストンテリア' },
    { id: 44, name: 'ポメラニアン' },
    { id: 45, name: 'マルチーズ' },
    { id: 46, name: 'ミニチュアシュナウザー' },
    { id: 47, name: 'ミニチュアダックスフンド' },
    { id: 48, name: 'ミニチュアピンシャー' },
    { id: 49, name: 'ヨークシャテリア' },
    { id: 50, name: 'ラフコリー' },
    { id: 51, name: 'ラブラドールレトリバー' }
  ]

  has_many :dogs
end
