class DrinkOption < ApplicationRecord
  belongs_to :drink
  has_many :price_histories, -> { where(item_type: 'drink_option') }, foreign_key: :item_id
  has_many :order_drinks

  validates :description, :price, presence: true

  before_update :save_price_history, if: :price_changed?

  private

  def save_price_history
    price_histories.create(price: price_was, start_date: created_at, end_date: updated_at, item_type: 'drink_option')
  end
end
