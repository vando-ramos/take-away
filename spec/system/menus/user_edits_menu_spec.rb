require 'rails_helper'

describe 'User edits menu' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

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
    click_on('Edit')

    expect(current_path).to eq(edit_menu_path(menu.id))
    expect(page).to have_content('Edit Lunch')
    expect(page).to have_field('Name')
    expect(page).to have_content('Dishes')
    expect(page).to have_field('menu[dish_ids][]')
    expect(page).to have_button('Update Menu')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

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
    DishOption.create!(dish: dish2, price: '15,00', description: 'Pequeno')
    DishOption.create!(dish: dish2, price: '25,00', description: 'Médio')

    menu = Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish1, dish2])

    login_as(user)
    visit(root_path)
    click_on('Lunch')
    click_on('Edit')
    fill_in 'Name', with: 'Dinner'
    uncheck 'Macarrão Carbonara'
    click_on('Update Menu')

    expect(current_path).to eq(menu_path(menu.id))
    expect(page).to have_content('Dinner')
    expect(page).to have_content('Menu successfully updated')
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

  it "and the name can't be blank" do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

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
    DishOption.create!(dish: dish2, price: '15,00', description: 'Pequeno')
    DishOption.create!(dish: dish2, price: '25,00', description: 'Médio')

    menu = Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish1, dish2])

    login_as(user)
    visit(root_path)
    click_on('Lunch')
    click_on('Edit')
    fill_in 'Name', with: ''
    uncheck 'Macarrão Carbonara'
    click_on('Update Menu')

    expect(page).to have_content('Unable to update menu')
    expect(page).to have_content("Name can't be blank")
  end
end
