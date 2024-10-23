class OperatingHoursController < ApplicationController
  def index
    @operating_hours = OperatingHour.all
  end
end
