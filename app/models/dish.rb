class Dish < ApplicationRecord
  belongs_to :establishment
  has_many :dish_options
  has_many :dish_tags
  has_many :tags, through: :dish_tags
  has_many :dish_menus
  has_many :menus, through: :dish_menus

  has_one_attached :image

  validates :name, :description, :calories, :image, presence: true

  enum status: { active: 0, inactive: 1 }
end
