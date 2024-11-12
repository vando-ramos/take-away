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
      redirect_to drinks_path, notice: 'Drink successfully registered'
    else
      flash.now.alert = 'Unable to register drink'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @drink.update(drink_params)
      redirect_to drinks_path, notice: 'Drink successfully updated'
    else
      flash.now.alert = 'Unable to update drink'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @drink.destroy
    redirect_to drinks_path, notice: 'Drink successfully deleted'
  end

  def active
    @drink.active!
    redirect_to drink_path(@drink.id), notice: 'Drink successfully activated'
  end

  def inactive
    @drink.inactive!
    redirect_to drink_path(@drink.id), notice: 'Drink successfully deactivated'
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
