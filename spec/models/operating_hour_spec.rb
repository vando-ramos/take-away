require 'rails_helper'

RSpec.describe OperatingHour, type: :model do
  describe 'associations' do
    it { should belong_to(:establishment) }
  end

  it { should define_enum_for(:status).with_values(opened: 0, closed: 1) }
  it { should define_enum_for(:day_of_week).with_values(sunday: 0 , monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6) }
end
