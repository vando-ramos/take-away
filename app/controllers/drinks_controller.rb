class DrinksController < ApplicationController
  before_action :authorize_admin!
  before_action :set_establishment
  before_action :set_drink, only: %i[show edit update destroy active inactive]

  def index
    @drinks = @establishment.drinks
  end

  def show
  end

  def new
    @drink = @establishment.drinks.build
  end

  def create
    @drink = @establishment.drinks.build(drink_params)

    if @drink.save
      redirect_to drinks_path, notice: t('notices.drink.registered')
    else
      flash.now.alert = t('alerts.drink.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @drink.update(drink_params)
      redirect_to drinks_path, notice: t('notices.drink.updated')
    else
      flash.now.alert = t('alerts.drink.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @drink.destroy
    redirect_to drinks_path, notice: t('notices.drink.deleted')
  end

  def active
    @drink.active!
    redirect_to drink_path(@drink.id), notice: t('notices.drink.activated')
  end

  def inactive
    @drink.inactive!
    redirect_to drink_path(@drink.id), notice: t('notices.drink.deactivated')
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_drink
    @drink = @establishment.drinks.find_by(id: params[:id])
    unless @drink
      redirect_to root_path, alert: 'Drink not found or you do not have access to this drink'
    end
  end

  def drink_params
    params.require(:drink).permit(:name, :description, :calories, :image, :is_alcoholic)
  end
end
