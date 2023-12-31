class Rating < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 2, name: '★★★★★' },
    { id: 3, name: '★★★★☆' },
    { id: 4, name: '★★★☆☆' },
    { id: 5, name: '★★☆☆☆' },
    { id: 6, name: '★☆☆☆☆' }
  ]

  has_many :posts
end
