class OperatingHour < ApplicationRecord
  belongs_to :establishment

  validates :day_of_week, :opening_time, :closing_time, :status, presence: true

  enum day_of_week: { sunday: 0 , monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6 }
  enum status: { opened: 0, closed: 1 }

  def translated_status
    I18n.t("activerecord.attributes.operating_hour.statuses.#{status}")
  end

  def translated_day_of_week
    index = self.class.day_of_weeks[day_of_week] || day_of_week_before_type_cast.to_i
    I18n.t('date.day_names')[index].humanize
  end
end
