class DishOptionsController < ApplicationController
  before_action :set_establishment_and_check_user
  before_action :set_dish
  before_action :set_dish_option, only: %i[edit update]

  def new
    @dish_option = @dish.dish_options.build
    @dishes = Dish.all
  end

  def create
    @dish_option = @dish.dish_options.build(dish_option_params)

    if @dish_option.save
      redirect_to establishment_dish_path(@establishment.id, @dish.id), notice: 'Dish option successfully registered'
    else
      flash.now.alert = 'Unable to register dish option'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dish_option.update(dish_option_params)
      redirect_to establishment_dish_path(@establishment.id, @dish.id), notice: 'Dish option successfully updated'
    else
      flash.now.alert = 'Unable to update dish option'
      render :edit, status: :unprocessable_entity
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

  def set_dish_option
    @dish_option = @dish.dish_options.find_by(id: params[:id])
    unless @dish_option
      redirect_to establishment_dish_path(@establishment.id, @dish.id), alert: 'Dish option not found'
    end
  end

  def dish_option_params
    params.require(:dish_option).permit(:dish_id, :description, :price)
  end
end
