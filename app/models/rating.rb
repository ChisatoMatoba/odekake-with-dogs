class Rating < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 2, name: '★★★★★' },
    { id: 3, name: '★★★★☆' },
    { id: 4, name: '★★★☆☆' },
    { id: 5, name: '★★☆☆☆' },
    { id: 6, name: '★☆☆☆☆' }
  ]

  # 検索の表示用
  def name_with_suffix
    "#{name}以上"
  end

  has_many :posts
end
