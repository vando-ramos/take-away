class OperatingHour < ApplicationRecord
  belongs_to :establishment

  enum day_of_week: { sunday: 0 , monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6}
  enum status: { opened: 0, closed: 1 }
end
