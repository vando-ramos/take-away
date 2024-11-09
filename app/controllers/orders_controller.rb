class OrdersController < ApplicationController
  before_action :set_establishment
  before_action :set_order, only: %i[show in_preparation canceled ready delivered]

  def index
    @orders = @establishment.orders
  end

  def show
  end

  def new
    @order = @establishment.orders.build
  end

  def create
    @order = @establishment.orders.build(order_params)

    if @order.save
      redirect_to @order, notice: 'Order successfully started'
    else
      flash.now.alert = 'Unable to start order'
      render :new, status: :unprocessable_entity
    end
  end

  def in_preparation
    @order.in_preparation!
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  def ready
    @order.ready!
    redirect_to @order
  end

  def delivered
    @order.delivered!
    redirect_to @order
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_order
    @order = @establishment.orders.find_by(id: params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_name, :customer_cpf, :customer_email, :customer_phone,
                                  :status, :code, :total_value)
  end
end
