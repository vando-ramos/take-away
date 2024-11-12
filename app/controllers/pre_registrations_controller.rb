class PreRegistrationsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_establishment

  def index
    @pre_registrations = @establishment.pre_registrations
  end

  def new
    @pre_registration = @establishment.pre_registrations.build
  end

  def create
    @pre_registration = @establishment.pre_registrations.build(pre_registration_params)

    if @pre_registration.save
      redirect_to pre_registrations_path, notice: 'User successfully registered'
    else
      flash.now.alert = 'Unable to register user'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def pre_registration_params
    params.require(:pre_registration).permit(:email, :cpf, :status)
  end
end
