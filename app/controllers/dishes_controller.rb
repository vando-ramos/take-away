class DishesController < ApplicationController
  before_action :set_establishment

  def index
    @dishes = @establishment.dishes
  end

  private

  def set_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end
end
