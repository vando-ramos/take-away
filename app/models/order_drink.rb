class OrderDrink < ApplicationRecord
  belongs_to :order
  belongs_to :drink
  belongs_to :drink_option

  validates :quantity, presence: true

  def total_price
    drink_option.price * quantity
  end
end
