class OrderDrinksController < ApplicationController
  before_action :set_establishment
  before_action :set_order, only: %i[new create]

  def new
    @order_drink = OrderDrink.new
    @drinks = @establishment.drinks.where(status: Drink.statuses[:active])
    @drink_options = DrinkOption.all
  end

  def create
    @order_drink = @order.order_drinks.build(order_drink_params)

    if @order_drink.save
      redirect_to order_path(@order.id), notice: 'Drink successfully added'
    else
      flash.now.alert = 'Unable to add drink'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_drink_params
    params.require(:order_drink).permit(:quantity, :observation, :order_id, :drink_id, :drink_option_id)
  end
end
