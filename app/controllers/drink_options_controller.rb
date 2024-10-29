class DrinkOptionsController < ApplicationController
  before_action :set_establishment_and_check_user
  before_action :set_drink

  def new
    @option = @drink.options.build
    @drinks = Drink.all
  end

  def create
    @option = @drink.options.build(option_params)

    if @option.save
      redirect_to establishment_drink_path(@establishment.id, @drink.id), notice: 'Option successfully registered'
    else
      flash.now.alert = 'Unable to register option'
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

  def option_params
    params.require(:option).permit(:drink_id, :description, :price)
  end
end
