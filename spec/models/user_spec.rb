require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it "name can't be blank" do
      user = User.new(name: '', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "last name can't be blank" do
      user = User.new(name: 'James', last_name: '', identification_number: CPF.generate, email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "identification number can't be blank" do
      user = User.new(name: 'James', last_name: 'Bond', identification_number: '', email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "identification number must be valid" do
      user = User.new(name: 'James', last_name: 'Bond', identification_number: '11122233344', email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
      expect(user.errors[:identification_number]).to include("is not valid")
    end

    it "identification number must be unique" do
      cpf = CPF.generate

      bond = User.create!(name: 'James', last_name: 'Bond', identification_number: cpf, email: 'bond@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      john = User.new(name: 'John', last_name: 'Wick', identification_number: cpf, email: 'wick@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(john.valid?).to eq false
    end

    it 'email must be valid' do
      user = User.new(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick.email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end
  end
end
