require 'rails_helper'

RSpec.describe Drink, type: :model do
  describe '#valid' do
    it "Name can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: '',
                        description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                        calories: 120, is_alcoholic: 'no',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Description can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: 'Limonada',
                        description: '',
                        calories: 120, is_alcoholic: 'no',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Calories can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: 'Limonada',
                        description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                        calories: '', is_alcoholic: 'no',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Is alcoholic can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: 'Limonada',
                        description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                        calories: 120, is_alcoholic: '',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Image can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: 'Limonada',
                        description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                        calories: 120, is_alcoholic: 'no',
                        image: '')

      expect(drink.valid?).to eq false
    end
  end

  describe 'associations' do
    it { should belong_to(:establishment) }
    it { should have_many(:drink_options) }
  end
end
