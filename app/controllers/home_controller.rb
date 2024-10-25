class HomeController < ApplicationController
  def index
    @establishment = current_user.establishment

    if @establishment.nil?
      redirect_to new_establishment_path, alert: 'Please register an establishment'
    end
  end
end
