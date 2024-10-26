class SearchController < ApplicationController
  def index
    @establishment = current_user.establishment

    @query = params[:query]

    if @query.present?
      @dishes = @establishment.dishes.where("name LIKE ? OR description LIKE ?", "%#{@query}%", "%#{@query}%")
      @drinks = @establishment.drinks.where("name LIKE ? OR description LIKE ?", "%#{@query}%", "%#{@query}%")
    end
  end
end
