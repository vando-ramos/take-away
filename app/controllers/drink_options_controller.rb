class DrinkOptionsController < ApplicationController
  before_action :set_establishment
  before_action :set_drink
  before_action :set_drink_option, only: %i[edit update]

  def new
    @drink_option = @drink.drink_options.build
    @drinks = Drink.all
  end

  def create
    @drink_option = @drink.drink_options.build(drink_option_params)

    if @drink_option.save
      redirect_to drink_path(@drink.id), notice: 'Drink option successfully registered'
    else
      flash.now.alert = 'Unable to register drink option'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @drink_option.update(drink_option_params)
      redirect_to drink_path(@drink.id), notice: 'Drink option successfully updated'
    else
      flash.now.alert = 'Unable to update drink option'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_drink
    @drink = Drink.find_by(id: params[:drink_id])
  end

  def set_drink_option
    @drink_option = @drink.drink_options.find_by(id: params[:id])
    unless @drink_option
      redirect_to drink_path(@drink.id), alert: 'Drink option not found'
    end
  end

  def drink_option_params
    params.require(:drink_option).permit(:drink_id, :description, :price)
  end
end
