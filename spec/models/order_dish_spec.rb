require 'rails_helper'

RSpec.describe OrderDish, type: :model do
  describe 'associations' do
    it { should belong_to(:dish) }
    it { should belong_to(:dish_option) }
    it { should belong_to(:order) }
  end
end
