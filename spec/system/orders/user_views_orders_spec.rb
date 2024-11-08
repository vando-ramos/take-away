require 'rails_helper'

describe 'User views orders' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'that belong to their establishment' do
    bond = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    wick = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                        email: 'wick@email.com', password: '123456789aaa',
                        password_confirmation: '123456789aaa')

    estab1 = Establishment.create!(user: bond, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    estab2 = Establishment.create!(user: wick, corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                  cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                  neighborhood: 'Centro', city: 'São Paulo', state: 'SP',
                                  zip_code: '10010-100', phone_number: '1140041234',
                                  email: 'contato@kfc.com.br')

    dish1 = Dish.create!(establishment: estab1, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish2 = Dish.create!(establishment: estab2, name: 'Macarrão Carbonara',
                        description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                        calories: 550,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    drink1 = Drink.create!(establishment: estab1, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink2 = Drink.create!(establishment: estab2, name: 'Mojito',
                          description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                          calories: 150, is_alcoholic: 'yes',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish1, price: '30,00', description: 'Média')
    DishOption.create!(dish: dish1, price: '50,00', description: 'Grande')
    DishOption.create!(dish: dish2, price: '15,00', description: 'Pequeno')
    DishOption.create!(dish: dish2, price: '25,00', description: 'Médio')
    DrinkOption.create!(drink: drink1, price: '5,00', description: '300ml')
    DrinkOption.create!(drink: drink1, price: '8,00', description: '500ml')
    DrinkOption.create!(drink: drink2, price: '15,00', description: '300ml')
    DrinkOption.create!(drink: drink2, price: '25,00', description: '500ml')

    Menu.create!(establishment: estab1, name: 'Lunch', dishes: [dish1], drinks: [drink1])
    Menu.create!(establishment: estab1, name: 'Drinks', drinks: [drink1], dishes: [dish1])
    Menu.create!(establishment: estab2, name: 'Drinks', drinks: [drink2], dishes: [dish2])

    order1 = Order.create!(user: bond, establishment: estab1, customer_name: 'Tony Stark',
                           customer_cpf: CPF.generate, customer_email: 'stark@email.com',
                           customer_phone: '21987654321', total_value: '58,00',
                           status: 'awaiting_kitchen_confirmation')

    order2 = Order.create!(user: bond, establishment: estab1, customer_name: 'Wanda Maximoff',
                           customer_cpf: CPF.generate, customer_email: 'wanda@email.com',
                           customer_phone: '21986427531', total_value: '35,00',
                           status: 'in_preparation')

    order3 = Order.create!(user: wick, establishment: estab2, customer_name: 'Bruce Wayne',
                           customer_cpf: CPF.generate, customer_email: 'wayne@email.com',
                           customer_phone: '21975318642', total_value: '30,00',
                           status: 'canceled')

    login_as(bond)
    visit(root_path)
    click_on('Orders')

    expect(page).to have_content('Orders')
    expect(page).to have_content(order1.code)
    expect(page).to have_content('Tony Stark')
    expect(page).to have_content('R$58,00')
    expect(page).to have_content('Awaiting kitchen confirmation')
    expect(page).to have_content(order2.code)
    expect(page).to have_content('Wanda Maximoff')
    expect(page).to have_content('R$35,00')
    expect(page).to have_content('In preparation')
    expect(page).not_to have_content(order3.code)
    expect(page).not_to have_content('Canceled')
  end
end
