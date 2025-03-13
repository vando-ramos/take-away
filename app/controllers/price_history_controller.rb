class PriceHistoryController < ApplicationController
  before_action :authorize_admin!

  def index
    @grouped_price_histories = PriceHistory.includes(:option).group_by(&:option)
  end
end
