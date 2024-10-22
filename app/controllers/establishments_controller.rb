class EstablishmentsController < ApplicationController
  before_action :set_order_and_check_user, only: %i[show]

  def show
  end

  private

  def set_order_and_check_user
    @establishment = Establishment.find(params[:id])

    if @establishment.user != current_user
      return redirect_to root_path, alert: 'You do not have access to other establishments'
    end
  end
end
