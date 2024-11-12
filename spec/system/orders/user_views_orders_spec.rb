require 'rails_helper'

describe 'User views orders' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'that belong to their establishment' do
    bond_estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                        brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                        address: 'Rua Comercial Sul', number: '123',
                                        neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                        zip_code: '70300-902', phone_number: '2198765432',
                                        email: 'contato@giraffas.com.br')

    wick_estab = Establishment.create!(corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                       cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                       neighborhood: 'Centro', city: 'São Paulo', state: 'SP',
                                       zip_code: '10010-100', phone_number: '1140041234',
                                       email: 'contato@kfc.com.br')

    bond = User.create!(establishment: bond_estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    wick = User.create!(establishment: wick_estab, name: 'John', last_name: 'Wick', cpf: CPF.generate,
                        email: 'wick@email.com', password: '123456789aaa',
                        password_confirmation: '123456789aaa', role: 'admin')

    dish = Dish.create!(establishment: bond_estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    drink = Drink.create!(establishment: wick_estab, name: 'Mojito',
                          description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                          calories: 150, is_alcoholic: 'yes',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    dish_option1 = DishOption.create!(dish: dish, price: '30,00', description: 'Média')
    dish_option2 = DishOption.create!(dish: dish, price: '50,00', description: 'Grande')
    drink_option1 = DrinkOption.create!(drink: drink, price: '15,00', description: '300ml')
    drink_option2 = DrinkOption.create!(drink: drink, price: '25,00', description: '500ml')

    Menu.create!(establishment: bond_estab, name: 'Lunch', dishes: [dish], drinks: [drink])
    Menu.create!(establishment: bond_estab, name: 'Drinks', drinks: [drink], dishes: [dish])
    Menu.create!(establishment: wick_estab, name: 'Drinks', drinks: [drink], dishes: [dish])

    order1 = Order.create!(establishment: bond_estab, customer_name: 'Tony Stark',
                           customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                           customer_phone: '21987654321',
                           status: 'awaiting_kitchen_confirmation')

    order2 = Order.create!(establishment: bond_estab, customer_name: 'Wanda Maximoff',
                           customer_cpf: CPF.generate, customer_email: 'wanda@email.com',
                           customer_phone: '21986427531',
                           status: 'in_preparation')

    order3 = Order.create!(establishment: wick_estab, customer_name: 'Bruce Wayne',
                           customer_cpf: CPF.generate, customer_email: 'wayne@email.com',
                           customer_phone: '21975318642',
                           status: 'canceled')

    OrderDish.create!(dish: dish, dish_option: dish_option1, order: order1, quantity: 1, observation: 'Sem queijo')
    OrderDrink.create!(drink: drink, drink_option: drink_option1, order: order1, quantity: 1, observation: 'Sem açúcar')

    OrderDish.create!(dish: dish, dish_option: dish_option2, order: order2, quantity: 1, observation: 'Sem queijo')
    OrderDrink.create!(drink: drink, drink_option: drink_option2, order: order2, quantity: 1, observation: 'Sem açúcar')

    login_as(bond)
    visit(root_path)
    click_on('Orders')

    expect(page).to have_content('Orders')
    expect(page).to have_content(order1.code)
    expect(page).to have_content('Tony Stark')
    expect(page).to have_content('R$45,00')
    expect(page).to have_content('Awaiting kitchen confirmation')
    expect(page).to have_content(order2.code)
    expect(page).to have_content('Wanda Maximoff')
    expect(page).to have_content('R$75,00')
    expect(page).to have_content('In preparation')
    expect(page).not_to have_content(order3.code)
    expect(page).not_to have_content('Canceled')
  end

  it 'and sees details of an order' do
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

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')
    drink_option = DrinkOption.create!(drink: drink, price: '25,00', description: '500ml')

    Menu.create!(establishment: estab, name: 'Dinner', dishes: [dish], drinks: [drink])

    cpf = CPF.generate
    order = Order.create!(establishment: estab, customer_name: 'Tony Stark',
                           customer_cpf: cpf, customer_email: 'stark@email.com',
                           customer_phone: '21987654321', total_value: '55,00',
                           status: 'awaiting_kitchen_confirmation')

    OrderDish.create!(dish: dish, dish_option: dish_option, order: order, quantity: 1, observation: 'Sem queijo')

    OrderDrink.create!(drink: drink, drink_option: drink_option, order: order, quantity: 1, observation: 'Sem açúcar')

    login_as(user)
    visit(root_path)
    click_on('Orders')
    click_on(order.code)

    expect(page).to have_content("Order #{order.code}")
    expect(page).to have_content('Tony Stark')
    expect(page).to have_content(cpf)
    expect(page).to have_content('stark@email.com')
    expect(page).to have_content('21987654321')
    expect(page).to have_content('Awaiting kitchen confirmation')
    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('Média')
    expect(page).to have_content('R$30,00')
    expect(page).to have_content('1')
    expect(page).to have_content('Sem queijo')
    expect(page).to have_content('Mojito')
    expect(page).to have_content('500ml')
    expect(page).to have_content('R$25,00')
    expect(page).to have_content('1')
    expect(page).to have_content('Sem açúcar')
    expect(page).to have_content('Total: R$55,00')
  end
end
