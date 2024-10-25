class DishesController < ApplicationController
  before_action :set_establishment
  before_action :set_dish, only: %i[show edit update]

  def index
    @dishes = @establishment.dishes
  end

  def show
  end

  def new
    @dish = @establishment.dishes.build
  end

  def create
    @dish = @establishment.dishes.build(dish_params)

    if @dish.save
      redirect_to establishment_dishes_path(@establishment.id), notice: 'Dish successfully registered'
    else
      flash.now.alert = 'Unable to register dish'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dish.update(dish_params)
      redirect_to establishment_dishes_path(@establishment.id), notice: 'Dish successfully updated'
    else
      flash.now.alert = 'Unable to update dish'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def set_dish
    @dish = Dish.find(params[:id])
  end

  def dish_params
    params.require(:dish).permit(:name, :description, :calories, :image)
  end
end
