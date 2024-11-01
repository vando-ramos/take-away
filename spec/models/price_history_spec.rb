require 'rails_helper'

RSpec.describe PriceHistory, type: :model do
  it { should define_enum_for(:item_type).with_values(dish_option: 0, drink_option: 1) }
end
