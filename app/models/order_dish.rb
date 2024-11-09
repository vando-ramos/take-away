class OrderDish < ApplicationRecord
  belongs_to :order
  belongs_to :dish
  belongs_to :dish_option

  validates :quantity, presence: true

  def total_price
    dish_option.price * quantity
  end
end
