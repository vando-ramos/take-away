class OperatingHoursController < ApplicationController
  before_action :set_establishment

  def index
    # @operating_hours = OperatingHour.all
    @operating_hours = @establishment.operating_hours
  end

  def new
    # @operating_hour = @establishment.operating_hours.new
    @operating_hour = @establishment.operating_hours.build
  end

  def create
    # @operating_hour = @establishment.operating_hours.new(operating_hour_params)
    @operating_hour = @establishment.operating_hours.build(operating_hour_params)

    if @operating_hour.save
      redirect_to establishment_operating_hours_path(@establishment.id), notice: 'Operating hour successfully registered'
    else
      flash.now.alert = 'Unable to register operating hour'
      render :new
    end
  end

  private

  def set_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def operating_hour_params
    params.require(:operating_hour).permit(:day_of_week, :opening_time, :closing_time, :status)
  end
end
