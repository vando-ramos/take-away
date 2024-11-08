class DishOption < ApplicationRecord
  belongs_to :dish
  has_many :price_histories, -> { where(item_type: 'dish_option') }, foreign_key: :item_id

  validates :description, :price, presence: true

  before_update :save_price_history, if: :price_changed?

  private

  def save_price_history
    price_histories.create(price: price_was, start_date: created_at,
                           end_date: updated_at, item_type: 'dish_option')
  end
end
