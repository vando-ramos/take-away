class Dish < ApplicationRecord
  belongs_to :establishment
  has_many :dish_options

  has_one_attached :image

  validates :name, :description, :calories, :image, presence: true

  enum status: { active: 0, inactive: 1 }
end
