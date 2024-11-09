require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it "customer name can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order = Order.new(establishment: estab, customer_name: '',
                        customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                        customer_phone: '21987654321', total_value: '50,00')

      expect(order.valid?).to eq false
    end

    it "customer phone can't be blank if customer email not present" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order = Order.new(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                        customer_phone: '', total_value: '50,00')

      expect(order.valid?).to eq true
    end

    it "customer email can't be blank if customer phone not present" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order = Order.new(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: CPF.generate, customer_email: '',
                        customer_phone: '21987654321', total_value: '50,00')

      expect(order.valid?).to eq true
    end

    it "customer email or customer phone must be present" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order = Order.new(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: CPF.generate, customer_email: '',
                        customer_phone: '', total_value: '50,00')

      expect(order.valid?).to eq false
    end

    it "cpf must be valid" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order = Order.new(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: '11122233344', customer_email: 'stark@email.com',
                        customer_phone: '21987654321', total_value: '50,00')

      expect(order.valid?).to eq false
      expect(order.errors[:customer_cpf]).to include("is not valid")
    end

    it "email must be valid" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order = Order.new(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: CPF.generate, customer_email: 'stark-email.com',
                        customer_phone: '21987654321', total_value: '50,00')

      expect(order.valid?).to eq false
    end
  end

  describe 'generates a random code' do
    it 'when register an order' do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order = Order.new(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                        customer_phone: '21987654321', total_value: '50,00')

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq(8)
    end

    it 'and the code must be unique' do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order1 = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                        customer_phone: '21987654321', total_value: '50,00')

      order2 = Order.new(establishment: estab, customer_name: 'Tony Stark',
                        customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                        customer_phone: '21987654321', total_value: '50,00')

      order2.save!

      expect(order2.code).not_to eq(order1.code)
    end
  end

  describe 'associations' do
    it { should belong_to(:establishment) }
    it { should have_many(:dishes) }
    it { should have_many(:drinks) }
  end
end
