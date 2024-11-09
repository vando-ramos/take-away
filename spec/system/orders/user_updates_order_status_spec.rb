require 'rails_helper'

describe 'User updates the order status' do
  it 'to in preparation' do
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

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish])

    order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                           customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                           customer_phone: '21987654321', total_value: '55,00')

    OrderDish.create!(dish: dish, dish_option: dish_option, order: order, quantity: 1, observation: 'Sem queijo')

    login_as(user)
    visit(root_path)
    click_on('Orders')
    click_on(order.code)
    click_on('In preparation')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('In preparation')
    expect(page).not_to have_button('In preparation')
    expect(page).to have_button('Canceled')
    expect(page).to have_button('Ready')
  end

  it 'to canceled' do
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

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish])

    order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                           customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                           customer_phone: '21987654321', total_value: '55,00', status: 'in_preparation')

    OrderDish.create!(dish: dish, dish_option: dish_option, order: order, quantity: 1, observation: 'Sem queijo')

    login_as(user)
    visit(root_path)
    click_on('Orders')
    click_on(order.code)
    click_on('Canceled')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Canceled')
    expect(page).not_to have_button('Canceled')
    expect(page).not_to have_button('Ready')
    expect(page).not_to have_button('Delivered')
  end

  it 'to ready' do
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

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish])

    order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                           customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                           customer_phone: '21987654321', total_value: '55,00', status: 'in_preparation')

    OrderDish.create!(dish: dish, dish_option: dish_option, order: order, quantity: 1, observation: 'Sem queijo')

    login_as(user)
    visit(root_path)
    click_on('Orders')
    click_on(order.code)
    click_on('Ready')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Ready')
    expect(page).not_to have_button('Ready')
    expect(page).to have_button('Canceled')
    expect(page).to have_button('Delivered')
  end

  it 'to delivered' do
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

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish])

    order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                           customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                           customer_phone: '21987654321', total_value: '55,00', status: 'ready')

    OrderDish.create!(dish: dish, dish_option: dish_option, order: order, quantity: 1, observation: 'Sem queijo')

    login_as(user)
    visit(root_path)
    click_on('Orders')
    click_on(order.code)
    click_on('Delivered')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Delivered')
    expect(page).not_to have_button('Delivered')
    expect(page).not_to have_button('Canceled')
  end
end
