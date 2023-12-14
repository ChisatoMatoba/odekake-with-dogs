class Category < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 2, name: '宿泊' },
    { id: 3, name: 'カフェ・レストラン' },
    { id: 4, name: 'ドッグラン' },
    { id: 5, name: 'ペット用品店' },
    { id: 6, name: 'その他・複合施設' }
  ]

  has_many :facilities
end
