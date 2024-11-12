class DishesController < ApplicationController
  before_action :authorize_admin!
  before_action :set_establishment
  before_action :set_dish, only: %i[show edit update destroy active inactive]

  def index
    @tags = Tag.all

    @dishes = if params[:tag_id].present?
      @establishment.dishes.joins(:tags).where(tags: { id: params[:tag_id] })
    else
      @establishment.dishes
    end
  end

  def show
  end

  def new
    @dish = @establishment.dishes.build
  end

  def create
    @dish = @establishment.dishes.build(dish_params)

    if @dish.save
      redirect_to dishes_path, notice: 'Dish successfully registered'
    else
      flash.now.alert = 'Unable to register dish'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dish.update(dish_params)
      redirect_to dishes_path, notice: 'Dish successfully updated'
    else
      flash.now.alert = 'Unable to update dish'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dish.destroy
    redirect_to dishes_path, notice: 'Dish successfully deleted'
  end

  def active
    @dish.active!
    redirect_to dish_path(@dish.id), notice: 'Dish successfully activated'
  end

  def inactive
    @dish.inactive!
    redirect_to dish_path(@dish.id), notice: 'Dish successfully deactivated'
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_dish
    @dish = @establishment.dishes.find_by(id: params[:id])

    unless @dish
      return redirect_to root_path, alert: 'Dish not found or you do not have access to this dish'
    end
  end

  def dish_params
    params.require(:dish).permit(:name, :description, :calories, :image, tag_ids: [])
  end
end
