require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe '#valid' do
    it "Name can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      menu = Menu.new(establishment: estab, name: '', dishes: [dish])

      expect(menu.valid?).to eq false
    end

    it 'Name must be unique per establishment' do
      user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      menu = Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])
      menu = Menu.new(establishment: estab, name: 'Lunch', dishes: [dish])

      expect(menu.valid?).to eq false
    end
  end

  describe 'associations' do
    it { should belong_to(:establishment) }
    it { should have_many(:dish_menus) }
    it { should have_many(:dishes) }
    it { should have_many(:drink_menus) }
    it { should have_many(:drinks) }
  end
end
