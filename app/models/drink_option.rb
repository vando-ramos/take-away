class DrinkOption < ApplicationRecord
  belongs_to :drink

  validates :description, :price, presence: true
end
