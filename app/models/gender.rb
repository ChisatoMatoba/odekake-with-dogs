class Gender < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '男の子♂' },
    { id: 3, name: '女の子♀' }
  ]

  has_many :dogs
end
