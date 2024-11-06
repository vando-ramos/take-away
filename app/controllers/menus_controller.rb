class MenusController < ApplicationController
  before_action :set_establishment
  before_action :set_menu, only: %i[show]

  def show
    @dishes = @menu.dishes.includes(:dish_options).where(status: Dish.statuses[:active])
    @drinks = @menu.drinks.includes(:drink_options).where(status: Drink.statuses[:active])
  end

  def new
    @menu = @establishment.menus.build
    @dishes = @establishment.dishes.includes(:dish_options).order(:name)
    @drinks = @establishment.drinks.includes(:drink_options).order(:name)
  end

  def create
    @menu = @establishment.menus.build(menu_params)
    @dishes = @establishment.dishes.includes(:dish_options).order(:name)
    @drinks = @establishment.drinks.includes(:drink_options).order(:name)

    if @menu.save
      redirect_to root_path, notice: 'Menu successfully created'
    else
      flash.now.alert = 'Unable to create menu'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_menu
    @menu = @establishment.menus.find_by(id: params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, dish_ids: [], drink_ids: [])
  end
end
