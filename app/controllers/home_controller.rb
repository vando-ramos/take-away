class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    @establishment = current_user.establishment
  end
end
