require 'rails_helper'

RSpec.describe DishMenu, type: :model do
  describe 'associations' do
    it { should belong_to(:menu) }
    it { should belong_to(:dish) }
  end
end
