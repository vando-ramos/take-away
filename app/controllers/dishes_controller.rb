class DishesController < ApplicationController
  before_action :set_establishment_and_check_user
  before_action :set_dish, only: %i[show edit update destroy active inactive]

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

  def destroy
    @dish.destroy
    redirect_to establishment_dishes_path(@establishment.id), notice: 'Dish successfully deleted'
  end

  def active
    @dish.active!
    redirect_to establishment_dish_path(@establishment, @dish.id), notice: 'Dish successfully activated'
  end

  def inactive
    @dish.inactive!
    redirect_to establishment_dish_path(@establishment, @dish.id), notice: 'Dish successfully deactivated'
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
    @dish = @establishment.dishes.find_by(id: params[:id])
    unless @dish
      redirect_to establishment_dishes_path(@establishment.id), alert: 'Dish not found'
    end
  end

  def dish_params
    params.require(:dish).permit(:name, :description, :calories, :image)
  end
end
