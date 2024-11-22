class OperatingHoursController < ApplicationController
  before_action :authorize_admin!, only: %i[new create edit update]
  before_action :set_establishment
  before_action :set_operating_hour, only: %i[show edit update]

  def show
  end

  def new
    @operating_hour = @establishment.operating_hours.build
  end

  def create
    @operating_hour = @establishment.operating_hours.build(operating_hour_params)

    if @operating_hour.save
      redirect_to establishments_path, notice: t('notices.operating_hour.registered')
    else
      flash.now.alert = t('alerts.operating_hour.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @operating_hour.update(operating_hour_params)
      redirect_to establishments_path, notice: t('notices.operating_hour.updated')
    else
      flash.now.alert = t('alerts.operating_hour.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_operating_hour
    @operating_hour = @establishment.operating_hours.find_by(id: params[:id])

    unless @operating_hour
      return redirect_to establishments_path, alert: 'Operating hour not found'
    end
  end

  def operating_hour_params
    params.require(:operating_hour).permit(:day_of_week, :opening_time, :closing_time, :status)
  end
end
