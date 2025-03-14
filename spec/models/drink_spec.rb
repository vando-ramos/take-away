require 'rails_helper'

RSpec.describe Drink, type: :model do
  describe '#valid' do
    it "Name can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: '',
                        description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                        calories: 120, is_alcoholic: 'no',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Description can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: 'Limonada',
                        description: '',
                        calories: 120, is_alcoholic: 'no',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Calories can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: 'Limonada',
                        description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                        calories: '', is_alcoholic: 'no',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Is alcoholic can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                    cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      drink = Drink.new(establishment: estab, name: 'Limonada',
                        description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                        calories: 120, is_alcoholic: '',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

      expect(drink.valid?).to eq false
    end

    it "Image can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
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
    it { should have_many(:drink_menus) }
    it { should have_many(:menus) }
    it { should have_one_attached(:image) }
  end

  it { should define_enum_for(:is_alcoholic).with_values(yes: 0, no: 1) }
  it { should define_enum_for(:status).with_values(active: 0, inactive: 1) }
end
