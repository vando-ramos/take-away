class OrderDishesController < ApplicationController
  before_action :set_establishment
  before_action :set_order, only: %i[new create]

  def new
    @order_dish = OrderDish.new
    @dishes = @establishment.dishes.where(status: Dish.statuses[:active])
    @dish_options = [] if @dish_option.nil?
  end

  def create
    @order_dish = @order.order_dishes.build(order_dish_params)

    if @order_dish.save
      redirect_to order_path(@order.id), notice: t('notices.order_dish.added')
    else
      @dishes = @establishment.dishes.where(status: Dish.statuses[:active])
      @dish_options = DishOption.where(dish_id: order_dish_params[:dish_id])

      flash.now.alert = t('alerts.order_dish.added_fail')
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

  def order_dish_params
    params.require(:order_dish).permit(:quantity, :observation, :order_id, :dish_id, :dish_option_id)
  end
end
