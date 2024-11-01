class PriceHistory < ApplicationRecord
  validates :item_type, :item_id, :price, :start_date, :end_date, presence: true

  enum item_type: { dish_option: 0, drink_option: 1 }
end
