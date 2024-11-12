class DrinkPriceHistoryController < ApplicationController
  before_action :authorize_admin!
  
  def index
    @drink_price_histories = PriceHistory.where(item_type: :drink_option)

    @drink_options = DrinkOption.where(id: @drink_price_histories.pluck(:item_id)).index_by(&:id)
  end
end
