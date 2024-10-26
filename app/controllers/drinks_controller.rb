class DrinksController < ApplicationController
  before_action :set_establishment_and_check_user
  before_action :set_drink, only: %i[show edit update destroy]

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
      redirect_to establishment_drinks_path(@establishment.id), notice: 'Drink successfully registered'
    else
      flash.now.alert = 'Unable to register drink'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @drink.update(drink_params)
      redirect_to establishment_drinks_path(@establishment.id), notice: 'Drink successfully updated'
    else
      flash.now.alert = 'Unable to update drink'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @drink.destroy
    redirect_to establishment_drinks_path(@establishment.id), notice: 'Drink successfully deleted'
  end

  private

  def set_establishment_and_check_user
    @establishment = Establishment.find_by(id: params[:establishment_id])

    if @establishment.nil?
      return redirect_to root_path, alert: 'Establishment not found'
    elsif @establishment.user != current_user
      return redirect_to root_path,
      alert: 'You do not have access to drinks from other establishments'
    end
  end

  def set_drink
    @drink = @establishment.drinks.find_by(id: params[:id])
    unless @drink
      redirect_to establishment_drinks_path(@establishment.id), alert: 'Drink not found'
    end
  end

  def drink_params
    params.require(:drink).permit(:name, :description, :calories, :image, :is_alcoholic)
  end
end
