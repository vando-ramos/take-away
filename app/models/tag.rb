class Tag < ApplicationRecord
  has_many :dish_tags
  has_many :dishes, through: :dish_tags
  
  validates :name, presence: true
  validates :name, uniqueness: true
end
