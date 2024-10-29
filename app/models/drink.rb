class Drink < ApplicationRecord
  belongs_to :establishment
  has_many :drink_options

  has_one_attached :image

  enum is_alcoholic: { yes: 0, no: 1 }
  enum status: { active: 0, inactive: 1 }

  validates :name, :description, :calories, :image, :is_alcoholic, presence: true
end
