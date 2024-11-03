class HomeController < ApplicationController
  def index
    @establishment = current_user.establishment

    if @establishment.nil?
      return redirect_to new_establishment_path, alert: 'Please register an establishment'
    end

    @operating_hours = @establishment.operating_hours
  end
end
