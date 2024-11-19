require 'rails_helper'

describe 'User registers orders' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from home page' do
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

    drink = Drink.create!(establishment: estab, name: 'Mojito',
                          description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                          calories: 150, is_alcoholic: 'yes',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish, price: '30,00', description: 'Média')
    DrinkOption.create!(drink: drink, price: '25,00', description: '500ml')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish], drinks: [drink])

    login_as(user)
    visit(root_path)
    click_on('New Order')

    expect(current_path).to eq(new_order_path)
    expect(page).to have_content('New Order')
    expect(page).to have_field('Customer name')
    expect(page).to have_field('Customer cpf')
    expect(page).to have_field('Customer phone')
    expect(page).to have_field('Customer email')
    expect(page).to have_button('Start Order')
  end

  it "and enters the customer's information to start order" do
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

    drink = Drink.create!(establishment: estab, name: 'Mojito',
                          description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                          calories: 150, is_alcoholic: 'yes',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish, price: '30,00', description: 'Média')
    DrinkOption.create!(drink: drink, price: '25,00', description: '500ml')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish], drinks: [drink])

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCDE12345')

    cpf = CPF.generate

    login_as(user)
    visit(root_path)
    click_on('New Order')
    fill_in 'Customer name', with: 'Tony Stark'
    fill_in 'Customer cpf', with: cpf
    fill_in 'Customer phone', with: '21987654321'
    fill_in 'Customer email', with: 'stark@email.com'
    click_on('Start Order')

    expect(page).to have_content('Order ABCDE12345')
    expect(page).to have_content('Tony Stark')
    expect(page).to have_content(cpf)
    expect(page).to have_content('21987654321')
    expect(page).to have_content('stark@email.com')
    expect(page).to have_content('Awaiting kitchen confirmation')
    expect(page).to have_link('Add Dish')
    expect(page).to have_link('Add Drink')
  end

  it 'then add dishes to the order' do
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

    drink = Drink.create!(establishment: estab, name: 'Mojito',
                          description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                          calories: 150, is_alcoholic: 'yes',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish, price: '30,00', description: 'Média')
    DrinkOption.create!(drink: drink, price: '25,00', description: '500ml')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish], drinks: [drink])

    order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                          customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                          customer_phone: '21987654321')

    login_as(user)
    visit(order_path(order.id))
    click_on('Add Dish')
    select 'Pizza de Calabresa', from: 'order_dish[dish_id]'
    # select 'Select a dish option', from: 'order_dish[dish_option_id]'
    fill_in 'Quantity', with: '1'
    click_on('Add Dish')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Dish successfully added')
    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('Média')
    expect(page).to have_content('1')
    expect(page).to have_content('R$30,00')
  end

  it 'then add drinks to the order' do
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

    drink = Drink.create!(establishment: estab, name: 'Mojito',
                          description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                          calories: 150, is_alcoholic: 'yes',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish, price: '30,00', description: 'Média')
    DrinkOption.create!(drink: drink, price: '25,00', description: '500ml')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish], drinks: [drink])

    order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                          customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                          customer_phone: '21987654321')

    login_as(user)
    visit(order_path(order.id))
    click_on('Add Drink')
    select 'Mojito', from: 'order_drink[drink_id]'
    select '500ml', from: 'order_drink[drink_option_id]'
    fill_in 'Quantity', with: '2'
    click_on('Add Drink')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Drink successfully added')
    expect(page).to have_content('Mojito')
    expect(page).to have_content('500ml')
    expect(page).to have_content('2')
    expect(page).to have_content('R$50,00')
  end
end
