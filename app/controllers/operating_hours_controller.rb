class OperatingHoursController < ApplicationController
  before_action :set_establishment
  before_action :set_operating_hour, only: %i[show edit update]

  def index
    @operating_hours = @establishment.operating_hours
  end

  def show
  end

  def new
    @operating_hour = @establishment.operating_hours.build
  end

  def create
    @operating_hour = @establishment.operating_hours.build(operating_hour_params)

    if @operating_hour.save
      redirect_to establishment_operating_hours_path(@establishment.id), notice: 'Operating hour successfully registered'
    else
      flash.now.alert = 'Unable to register operating hour'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @operating_hour.update(operating_hour_params)
      redirect_to establishment_operating_hours_path(@establishment.id), notice: 'Operating hour successfully updated'
    else
      flash.now.alert = 'Unable to update the operating hour'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_operating_hour
    @operating_hour = @establishment.operating_hours.find_by(id: params[:id])

    if @operating_hour.nil?
      if OperatingHour.exists?(id: params[:id])
        redirect_to establishment_operating_hours_path(@establishment.id),
        alert: 'You do not have access to operating hours from other establishments'
      else
        redirect_to establishment_operating_hours_path(@establishment.id), alert: 'Operating hours not found'
      end
    end
  end

  def operating_hour_params
    params.require(:operating_hour).permit(:day_of_week, :opening_time, :closing_time, :status)
  end
end
