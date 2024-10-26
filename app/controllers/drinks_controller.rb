class DrinksController < ApplicationController
  before_action :set_establishment
  before_action :set_drink, only: %i[show]

  def index
    @drinks = @establishment.drinks
  end

  def show
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_drink
    @drink = @establishment.drinks.find_by(id: params[:id])

    if @drink.nil?
      if Drink.exists?(id: params[:id])
        redirect_to establishment_drinks_path(@establishment.id), alert: 'You do not have access to drinks from other establishments'
      else
        redirect_to establishment_drinks_path(@establishment.id), alert: 'Drink not found'
      end
    end
  end
end
