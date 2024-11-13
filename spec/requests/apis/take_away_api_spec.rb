require 'rails_helper'

describe 'Take Away API', type: :request do
  context 'GET /api/v1/establishments/:establishment_code/orders' do
    it 'success' do
      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                          brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                          address: 'Rua Comercial Sul', number: '123',
                                          neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                          zip_code: '70300-902', phone_number: '2198765432',
                                          email: 'contato@giraffas.com.br')

      user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      dish_option1 = DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      dish_option2 = DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      order1 = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                            customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                            customer_phone: '21987654321',
                            status: 'awaiting_kitchen_confirmation')

      order2 = Order.create!(establishment: estab, customer_name: 'Wanda Maximoff',
                            customer_cpf: CPF.generate, customer_email: 'wanda@email.com',
                            customer_phone: '21986427531',
                            status: 'in_preparation')

      get "/api/v1/establishments/#{estab.code}/orders"

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
      expect(json_response[0]['customer_name']).to eq('Tony Stark')
      expect(json_response[1]['customer_name']).to eq('Wanda Maximoff')
    end
  end

  context 'GET /api/v1/establishments/:establishment_code/orders/:code' do
    it 'success' do
      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                          brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                          address: 'Rua Comercial Sul', number: '123',
                                          neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                          zip_code: '70300-902', phone_number: '2198765432',
                                          email: 'contato@giraffas.com.br')

      user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      dish_option1 = DishOption.create!(dish: dish, price: '30,00', description: 'Média')
      dish_option2 = DishOption.create!(dish: dish, price: '50,00', description: 'Grande')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      cpf = CPF.generate
      order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                            customer_cpf: cpf, customer_email: 'stark@email.com',
                            customer_phone: '21987654321',
                            status: 'awaiting_kitchen_confirmation')

      OrderDish.create!(dish: dish, dish_option: dish_option1, order: order, quantity: 2, observation: '')

      get "/api/v1/establishments/#{estab.code}/orders/#{order.code}"

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      first_dish = json_response['dishes'].first
      expect(json_response['customer_name']).to eq('Tony Stark')
      expect(json_response['customer_cpf']).to eq(cpf)
      expect(json_response['customer_phone']).to eq('21987654321')
      expect(json_response['customer_email']).to eq('stark@email.com')
      expect(json_response['status']).to eq('awaiting_kitchen_confirmation')
      expect(first_dish['name']).to eq('Pizza de Calabresa')
      expect(first_dish['option_description']).to eq('Média')
      expect(first_dish['quantity']).to eq(2)
      expect(first_dish['observation']).to eq('')
      expect(first_dish['price']).to eq('R$60,00')
      expect(json_response['total_value']).to eq('R$60,00')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end
  end

  context 'PATCH /api/v1/establishments/:establishment_code/orders/:code/in_preparation' do
    it 'success' do
      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                          brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                          address: 'Rua Comercial Sul', number: '123',
                                          neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                          zip_code: '70300-902', phone_number: '2198765432',
                                          email: 'contato@giraffas.com.br')

      user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      cpf = CPF.generate
      order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                            customer_cpf: cpf, customer_email: 'stark@email.com',
                            customer_phone: '21987654321',
                            status: 'awaiting_kitchen_confirmation')

      OrderDish.create!(dish: dish, dish_option: dish_option, order: order, quantity: 1, observation: '')

      patch "/api/v1/establishments/#{estab.code}/orders/#{order.code}/in_preparation"

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Order updated to in preparation')
      expect(order.reload.status).to eq('in_preparation')
    end
  end

  context 'PATCH /api/v1/establishments/:establishment_code/orders/:code/ready' do
    it 'success' do
      estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                          brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                          address: 'Rua Comercial Sul', number: '123',
                                          neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                          zip_code: '70300-902', phone_number: '2198765432',
                                          email: 'contato@giraffas.com.br')

      user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef',
                          password_confirmation: '123456abcdef', role: 'admin')

      dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                          description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                          calories: 265,
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

      dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')

      Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish])

      cpf = CPF.generate
      order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                            customer_cpf: cpf, customer_email: 'stark@email.com',
                            customer_phone: '21987654321',
                            status: 'awaiting_kitchen_confirmation')

      OrderDish.create!(dish: dish, dish_option: dish_option, order: order, quantity: 1, observation: '')

      patch "/api/v1/establishments/#{estab.code}/orders/#{order.code}/ready"

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Order updated to ready')
      expect(order.reload.status).to eq('ready')
    end
  end
end
