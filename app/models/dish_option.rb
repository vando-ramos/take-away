class DishOption < ApplicationRecord
  belongs_to :dish

  validates :description, :price, presence: true
end
