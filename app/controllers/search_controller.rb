class SearchController < ApplicationController
  def index
    @query = params[:query]
    @dishes = Dish.where("name LIKE ?", "%#{@query}%") if @query.present?
  end
end
