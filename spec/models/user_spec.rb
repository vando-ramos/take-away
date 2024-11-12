require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it "name can't be blank" do
      user = User.new(name: '', last_name: 'Bond', cpf: CPF.generate, email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "last name can't be blank" do
      user = User.new(name: 'James', last_name: '', cpf: CPF.generate, email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "cpf can't be blank" do
      user = User.new(name: 'James', last_name: 'Bond', cpf: '', email: 'bond@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it "cpf must be valid" do
      user = User.new(name: 'James', last_name: 'Bond', cpf: '11122233344',
                      email: 'bond@email.com', password: '123456abcdef',
                      password_confirmation: '123456abcdef', role: 'admin')

      expect(user.valid?).to eq false
      expect(user.errors[:cpf]).to include("is not valid")
    end

    it "cpf must be unique" do
      cpf = CPF.generate

      bond = User.create!(name: 'James', last_name: 'Bond', cpf: cpf, email: 'bond@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

      john = User.new(name: 'John', last_name: 'Wick', cpf: cpf, email: 'wick@email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

      expect(john.valid?).to eq false
    end

    it 'email must be valid' do
      user = User.new(name: 'John', last_name: 'Wick', cpf: CPF.generate, email: 'wick.email.com',
                      password: '123456abcdef', password_confirmation: '123456abcdef')

      expect(user.valid?).to eq false
    end

    it 'password must be at least 12 characters long' do
      user = User.new(name: 'James', last_name: 'Bond', cpf: CPF.generate, email: 'bond@email.com',
                      password: '123456', password_confirmation: '123456', role: 'admin')

      user.valid?

      expect(user.errors.include? :password).to be true
      expect(user.errors[:password]).to include('is too short (minimum is 12 characters)')
    end
  end

  describe 'associations' do
    it { should belong_to(:establishment).optional }
  end
end
