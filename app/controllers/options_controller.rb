class OptionsController < ApplicationController
  before_action :set_establishment_and_check_user
  before_action :set_dish

  def new
    @option = @dish.options.build
    @dishes = Dish.all
    @drinks = Drink.all
  end

  def create
    @option = @dish.options.build(option_params)

    if @option.save
      redirect_to establishment_dish_path(@establishment.id, @dish.id), notice: 'Option successfully registered'
    else
      flash.now.alert = 'Unable to register option'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_establishment_and_check_user
    @establishment = Establishment.find_by(id: params[:establishment_id])

    if @establishment.nil?
      return redirect_to root_path, alert: 'Establishment not found'
    elsif @establishment.user != current_user
      return redirect_to root_path,
      alert: 'You do not have access to dishes from other establishments'
    end
  end

  def set_dish
    @dish = Dish.find_by(id: params[:dish_id])
  end

  def option_params
    params.require(:option).permit(:dish_id, :drink_id, :description, :price)
  end
end
