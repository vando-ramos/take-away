require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it "name can't be blank" do
      user = User.new(name: '', last_name: 'Bond', identification_number: '111.222.333-44', email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "last name can't be blank" do
      user = User.new(name: 'James', last_name: '', identification_number: '111.222.333-44', email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "identification number can't be blank" do
      user = User.new(name: 'James', last_name: 'Bond', identification_number: '', email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end
  end
end
