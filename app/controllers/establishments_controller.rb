class EstablishmentsController < ApplicationController
  before_action :set_establishment_and_check_user, only: %i[show]
  before_action :check_user_establishment, only: %i[new create]

  def show
  end

  def new
    @establishment = Establishment.new
  end

  def create
    @establishment = current_user.build_establishment(establishment_params)

    if @establishment.save
      redirect_to establishment_path(@establishment), notice: 'Establishment successfully registered'
    else
      flash.now.alert = 'Unable to register establishment'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_establishment_and_check_user
    @establishment = Establishment.find_by(id: params[:id])

    if @establishment.nil?
      return redirect_to root_path, alert: 'Establishment not found'
    elsif @establishment.user != current_user
      return redirect_to root_path, alert: 'You do not have access to other establishments'
    end
  end

  def check_user_establishment
    if current_user.establishment.present?
      redirect_to root_path, alert: 'You already have an establishment'
    end
  end

  def establishment_params
    params.require(:establishment).permit(:corporate_name, :brand_name, :cnpj, :address, :number, :neighborhood,
                                          :city, :state, :zip_code, :phone_number, :email, :code)
  end
end
