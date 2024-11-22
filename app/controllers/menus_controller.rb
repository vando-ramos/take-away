class MenusController < ApplicationController
  before_action :set_establishment
  before_action :set_menu, only: %i[show edit update]
  before_action :set_menu_items, only: %i[new create edit update]

  def show
    @dishes = @menu.dishes.includes(:dish_options).where(status: Dish.statuses[:active])
    @drinks = @menu.drinks.includes(:drink_options).where(status: Drink.statuses[:active])
  end

  def new
    @menu = @establishment.menus.build
  end

  def create
    @menu = @establishment.menus.build(menu_params)

    if @menu.save
      redirect_to root_path, notice: t('notices.menu.created')
    else
      flash.now.alert = t('alerts.menu.create_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      redirect_to @menu, notice: t('notices.menu.updated')
    else
      flash.now.alert = t('alerts.menu.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_menu
    @menu = @establishment.menus.find_by(id: params[:id])
  end

  def set_menu_items
    @dishes = @establishment.dishes.includes(:dish_options).order(:name)
    @drinks = @establishment.drinks.includes(:drink_options).order(:name)
  end

  def menu_params
    params.require(:menu).permit(:name, dish_ids: [], drink_ids: [])
  end
end
