require 'rails_helper'

RSpec.describe DrinkMenu, type: :model do
  describe 'associations' do
    it { should belong_to(:menu) }
    it { should belong_to(:drink) }
  end
end
