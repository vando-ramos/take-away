class DishesController < ApplicationController
  before_action :authorize_admin!
  before_action :set_establishment
  before_action :set_dish, only: %i[show edit update active inactive]

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
      redirect_to dishes_path, notice: t('notices.dish.registered')
    else
      flash.now.alert = t('alerts.dish.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dish.update(dish_params)
      redirect_to dishes_path, notice: t('notices.dish.updated')
    else
      flash.now.alert = t('alerts.dish.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def active
    @dish.active!
    redirect_to dish_path(@dish.id), notice: t('notices.dish.activated')
  end

  def inactive
    @dish.inactive!
    redirect_to dish_path(@dish.id), notice: t('notices.dish.deactivated')
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
    type_key = params[:dish] ? :dish : :item
    params.require(type_key).permit(:name, :description, :calories, :image, tag_ids: []).merge(type: 'Dish')
  end
end
