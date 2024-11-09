require 'rails_helper'

RSpec.describe OrderDrink, type: :model do
  describe 'associations' do
    it { should belong_to(:drink) }
    it { should belong_to(:drink_option) }
    it { should belong_to(:order) }
  end
end
