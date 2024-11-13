class Api::V1::OrdersController < Api::V1::ApiController
  include ActionView::Helpers::NumberHelper
  
  before_action :set_establishment
  before_action :set_order, only: %i[show in_preparation ready]

  def index
    orders = @establishment.orders
    orders = orders.where(status: params[:status]) if params[:status].present? && Order.statuses.keys.include?(params[:status])
    render status: 200, json: orders
  end

  def show
    render status: 200, json: order_data
  end

  def in_preparation
    if @order.update(status: 'in_preparation')
      render status: 200, json: { message: 'Order updated to in preparation' }
    else
      render status: 422, json: { errors: @order.errors.full_messages }
    end
  end

  def ready
    if @order.update(status: 'ready')
      render status: 200, json: { message: 'Order updated to ready' }
    else
      render status: 422, json: { errors: @order.errors.full_messages }
    end
  end

  private

  def set_establishment
    @establishment = Establishment.find_by!(code: params[:establishment_code])
  end

  def set_order
    @order = @establishment.orders.find_by!(code: params[:code])
  end

  def order_data
    {
      establishment_code: @establishment.code,
      order_code: @order.code,
      customer_name: @order.customer_name,
      customer_cpf: @order.customer_cpf,
      customer_phone: @order.customer_phone,
      customer_email: @order.customer_email,
      status: @order.status,
      total_value: number_to_currency(@order.total_price),
      dishes: @order.order_dishes.map do |order_dish|
        {
          name: order_dish.dish.name,
          description: order_dish.dish.description,
          quantity: order_dish.quantity,
          option_description: order_dish.dish_option.description,
          price: number_to_currency(order_dish.total_price),
          observation: order_dish.observation
        }
      end,
      drinks: @order.order_drinks.map do |order_drink|
        {
          name: order_drink.drink.name,
          description: order_drink.drink.description,
          quantity: order_drink.quantity,
          option_description: order_drink.drink_option.description,
          price: number_to_currency(order_drink.total_price),
          observation: order_drink.observation
        }
      end
    }
  end
end
