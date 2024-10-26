class Drink < ApplicationRecord
  belongs_to :establishment

  has_one_attached :image

  enum is_alcoholic: { yes: 0, no: 1 }
end
