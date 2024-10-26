class Drink < ApplicationRecord
  belongs_to :establishment

  has_one_attached :image

  enum is_alcoholic: { yes: 0, no: 1 }

  validates :name, :description, :calories, :image, :is_alcoholic, presence: true
end
