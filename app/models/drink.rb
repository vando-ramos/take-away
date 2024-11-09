class Drink < ApplicationRecord
  belongs_to :establishment
  has_many :drink_options, dependent: :destroy
  has_many :drink_menus
  has_many :menus, through: :drink_menus
  has_many :order_drinks
  has_many :orders, through: :order_drinks

  has_one_attached :image

  enum is_alcoholic: { yes: 0, no: 1 }
  enum status: { active: 0, inactive: 1 }

  validates :name, :description, :calories, :image, :is_alcoholic, presence: true
end
