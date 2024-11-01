class DishPriceHistoryController < ApplicationController
  def index
    @dish_price_histories = PriceHistory.where(item_type: :dish_option)

    @dish_options = DishOption.where(id: @dish_price_histories.pluck(:item_id)).index_by(&:id)
  end
end
