require 'rails_helper'

describe 'User views details of a menu' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the home page' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    dish1 = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish2 = Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                        description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                        calories: 550,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish1, price: '30,00', description: 'Média')
    DishOption.create!(dish: dish1, price: '50,00', description: 'Grande')
    DishOption.create!(dish: dish2, price: '20,00', description: 'Médio')
    DishOption.create!(dish: dish2, price: '30,00', description: 'Grande')

    menu = Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish1, dish2])

    login_as(user)
    visit(root_path)
    click_on('Lunch')

    expect(current_path).to eq(menu_path(menu.id))
    expect(page).to have_content('Lunch')
    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('Média')
    expect(page).to have_content('R$30,00')
    expect(page).to have_content('Grande')
    expect(page).to have_content('R$50,00')
    expect(page).to have_content('Macarrão Carbonara')
    expect(page).to have_content('Médio')
    expect(page).to have_content('R$20,00')
    expect(page).to have_content('Grande')
    expect(page).to have_content('R$30,00')
  end

  it 'and sees only active dishes and drinks' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    dish1 = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish2 = Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                        description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                        calories: 550, status: 'inactive',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish1, price: '30,00', description: 'Média')
    DishOption.create!(dish: dish1, price: '50,00', description: 'Grande')
    DishOption.create!(dish: dish2, price: '15,00', description: 'Pequeno')
    DishOption.create!(dish: dish2, price: '25,00', description: 'Médio')

    menu = Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish1, dish2])

    login_as(user)
    visit(root_path)
    click_on('Lunch')

    expect(current_path).to eq(menu_path(menu.id))
    expect(page).to have_content('Lunch')
    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('Média')
    expect(page).to have_content('R$30,00')
    expect(page).to have_content('Grande')
    expect(page).to have_content('R$50,00')
    expect(page).not_to have_content('Macarrão Carbonara')
    expect(page).not_to have_content('Pequeno')
    expect(page).not_to have_content('R$15,00')
    expect(page).not_to have_content('Médio')
    expect(page).not_to have_content('R$25,00')
  end

  it 'and there are no items on the menu' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    menu = Menu.create!(establishment: estab, name: 'Lunch')

    login_as(user)
    visit(root_path)
    click_on('Lunch')

    expect(current_path).to eq(menu_path(menu.id))
    expect(page).to have_content('Lunch')
    expect(page).to have_content('There are no items on the menu')
  end

  it 'and there are no options registered for the menu items' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    dish1 = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish2 = Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                        description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                        calories: 550,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    menu = Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish1, dish2])

    login_as(user)
    visit(root_path)
    click_on('Lunch')

    expect(current_path).to eq(menu_path(menu.id))
    expect(page).to have_content('Lunch')
    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('There are no options registered for Pizza de Calabresa')
    expect(page).to have_content('Macarrão Carbonara')
    expect(page).to have_content('There are no options registered for Macarrão Carbonara')
  end
end
