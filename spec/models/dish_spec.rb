require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe '#valid' do
    it "Name can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      dish = Dish.new(establishment: estab, name: '',
                      description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                      calories: 265,
                      image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      expect(dish.valid?).to eq false
    end

    it "Description can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      dish = Dish.new(establishment: estab, name: 'Pizza de Calabresa',
                      description: '',
                      calories: 265,
                      image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      expect(dish.valid?).to eq false
    end

    it "Calories can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      dish = Dish.new(establishment: estab, name: 'Pizza de Calabresa',
                      description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                      calories: '',
                      image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      expect(dish.valid?).to eq false
    end

    it "Image can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      dish = Dish.new(establishment: estab, name: 'Pizza de Calabresa',
                      description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                      calories: 265,
                      image: '')

      expect(dish.valid?).to eq false
    end
  end

  describe 'associations' do
    it { should belong_to(:establishment) }
  end
end
