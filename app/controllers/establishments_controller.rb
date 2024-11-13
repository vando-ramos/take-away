class EstablishmentsController < ApplicationController
  before_action :authorize_admin!, only: %i[new create]
  before_action :set_establishment_and_check_user, only: %i[show]
  before_action :check_user_establishment, only: %i[new create]

  def index
    @establishment = current_user.establishment

    if @establishment.nil?
      return redirect_to new_establishment_path, alert: 'Please register an establishment'
    end

    @operating_hours = @establishment.operating_hours.order(:day_of_week)
  end

  def show
  end

  def new
    @establishment = Establishment.new
  end

  def create
    @establishment = current_user.build_establishment(establishment_params)

    if @establishment.save
      current_user.update(establishment: @establishment)
      redirect_to establishment_path(@establishment), notice: 'Establishment successfully registered'
    else
      flash.now.alert = 'Unable to register establishment'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_establishment_and_check_user
    @establishment = Establishment.find_by(id: params[:id])

    if @establishment.nil? || !@establishment.users.include?(current_user)
      return redirect_to establishments_path, alert: 'Establishment not found or you do not have access'
    end
  end

  def check_user_establishment
    if current_user.establishment.present?
      return redirect_to establishments_path, alert: 'You already have an establishment'
    end
  end

  def establishment_params
    params.require(:establishment).permit(:corporate_name, :brand_name, :cnpj, :address, :number, :neighborhood,
                                          :city, :state, :zip_code, :phone_number, :email, :code)
  end
end
