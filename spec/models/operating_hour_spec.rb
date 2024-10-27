require 'rails_helper'

RSpec.describe OperatingHour, type: :model do
  describe 'associations' do
    it { should belong_to(:establishment) }
  end
end
