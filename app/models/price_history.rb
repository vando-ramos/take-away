class PriceHistory < ApplicationRecord
  belongs_to :option

  validates :price, :start_date, :end_date, presence: true
end
