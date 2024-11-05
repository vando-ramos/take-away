class DrinkMenu < ApplicationRecord
  belongs_to :drink
  belongs_to :menu
end
