class DishOptionsController < ApplicationController
  before_action :set_establishment
  before_action :set_dish
  before_action :set_dish_option, only: %i[edit update]

  def new
    @dish_option = @dish.dish_options.build
    @dishes = Dish.all
  end

  def create
    @dish_option = @dish.dish_options.build(dish_option_params)

    if @dish_option.save
      redirect_to dish_path(@dish.id), notice: 'Dish option successfully registered'
    else
      flash.now.alert = 'Unable to register dish option'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dish_option.update(dish_option_params)
      redirect_to dish_path(@dish.id), notice: 'Dish option successfully updated'
    else
      flash.now.alert = 'Unable to update dish option'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_dish
    @dish = Dish.find_by(id: params[:dish_id])
  end

  def set_dish_option
    @dish_option = @dish.dish_options.find_by(id: params[:id])
    unless @dish_option
      redirect_to dish_path(@dish.id), alert: 'Dish option not found'
    end
  end

  def dish_option_params
    params.require(:dish_option).permit(:dish_id, :description, :price)
  end
end
