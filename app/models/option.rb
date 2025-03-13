class Option < ApplicationRecord
  belongs_to :optionable, polymorphic: true
  has_many :price_histories
  # has_many :price_histories, -> { where(item_type: 'option') }, foreign_key: :item_id
  # has_many :order_items

  validates :description, :price, presence: true

  before_update :save_price_history, if: :price_changed?

  private

  def save_price_history
    price_histories.create(price: price_was, start_date: created_at, end_date: updated_at)
  end
end
