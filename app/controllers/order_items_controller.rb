class OrderItemsController < ApplicationController
  before_action :set_establishment
  before_action :set_order, only: %i[new create]

  def new
    @order_item = OrderItem.new
    @items = @establishment.items.where(status: Item.statuses[:active])
    @options = [] if @option.nil?
  end

  def create
    @order_item = @order.order_items.build(order_item_params)

    if @order_item.save
      redirect_to order_path(@order.id), notice: t('notices.order_dish.added')
    else
      @items = @establishment.items.where(status: Item.statuses[:active])
      @options = Option.where(item_id: order_item_params[:item_id])

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

  def order_item_params
    params.require(:order_item).permit(:quantity, :observation, :order_id, :item_id, :option_id)
  end
end
