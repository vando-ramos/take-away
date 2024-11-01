require 'rails_helper'

RSpec.describe DishTag, type: :model do
  describe 'associations' do
    it { should belong_to(:tag) }
    it { should belong_to(:dish) }
  end
end
