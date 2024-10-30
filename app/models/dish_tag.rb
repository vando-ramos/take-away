class DishTag < ApplicationRecord
  belongs_to :tag
  belongs_to :dish
end
