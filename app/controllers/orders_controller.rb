class OrdersController < ApplicationController
  before_action :set_establishment

  def index
    @orders = @establishment.orders
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end
end
