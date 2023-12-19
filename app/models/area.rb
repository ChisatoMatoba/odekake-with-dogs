# Prefectureから地域(Area)を定義する
class Area < ActiveHash::Base
  include ActiveHash::Associations
  has_many :prefectures, dependent: :restrict_with_exception

  # 地域と都道府県IDのマッピング
  self.data = [
    { id: 1, name: '北海道' },
    { id: 2, name: '東北' },
    { id: 3, name: '関東' },
    { id: 4, name: '中部' },
    { id: 5, name: '近畿' },
    { id: 6, name: '中国四国' },
    { id: 7, name: '九州' },
    { id: 8, name: '沖縄' }
  ]
end
