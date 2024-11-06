class Menu < ApplicationRecord
  belongs_to :establishment
  has_many :dish_menus
  has_many :dishes, through: :dish_menus
  has_many :drink_menus
  has_many :drinks, through: :drink_menus

  validates :name, presence: true
end
