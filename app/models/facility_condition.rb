class FacilityCondition < ActiveHash::Base
  self.data = [
    { id: 1, name: '大型犬OK' },
    { id: 2, name: 'リード外してOK' },
    { id: 3, name: 'リード必須' },
    { id: 4, name: 'キャリーケース・カート必須' },
    { id: 5, name: 'ドッグラン併設' },
    { id: 6, name: '駐車場少ないので注意' }
  ]
end
