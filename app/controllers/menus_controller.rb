class MenusController < ApplicationController
  before_action :set_menu, only: %i[show]

  def show
    @dishes = @menu.dishes.includes(:dish_options)
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
