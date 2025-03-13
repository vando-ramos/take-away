class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :option

  validates :quantity, presence: true

  after_save :update_order_total
  after_destroy :update_order_total

  def total_price
    option.price * quantity
  end

  private

  def update_order_total
    order.update_total_value!
  end
end
