class DrinkOptionsController < ApplicationController
  before_action :set_establishment_and_check_user
  before_action :set_drink

  def new
    @drink_option = @drink.drink_options.build
    @drinks = Drink.all
  end

  def create
    @drink_option = @drink.drink_options.build(drink_option_params)

    if @drink_option.save
      redirect_to establishment_drink_path(@establishment.id, @drink.id), notice: 'Drink option successfully registered'
    else
      flash.now.alert = 'Unable to register drink option'
      render :new, status: :unprocessable_entity
    end
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

  def set_drink
    @drink = Drink.find_by(id: params[:drink_id])
  end

  def drink_option_params
    params.require(:drink_option).permit(:drink_id, :description, :price)
  end
end
