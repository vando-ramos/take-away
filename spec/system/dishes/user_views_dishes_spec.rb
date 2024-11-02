require 'rails_helper'

describe 'User views the dishes' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                 description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                 calories: 265,
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'),
                 status: 'active')

    Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                 description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                 calories: 550,
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'),
                 status: 'inactive')

    login_as(user)
    visit(root_path)
    click_on('Dishes')

    expect(current_path).to eq(dishes_path)
    expect(page).to have_content('Dishes')
    expect(page).to have_content('Pizza de Calabresa (Active)')
    expect(page).to have_content('Pizza com molho de tomate, queijo, calabresa e orégano')
    expect(page).to have_content('265 cal')
    expect(page).to have_css("img[src*='pizza-calabresa.jpg']")
    expect(page).to have_content('Macarrão Carbonara (Inactive)')
    expect(page).to have_content('Macarrão com molho cremoso à base de ovos, queijo e bacon')
    expect(page).to have_content('550 cal')
    expect(page).to have_css("img[src*='carbonara.jpg']")
  end

  it 'and there is no dishes registered' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902',
                                  phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('Dishes')

    expect(current_path).to eq(dishes_path)
    expect(page).to have_content('Dishes')
    expect(page).to have_content('There is no dishes registered')
  end

  it 'and the dish not found' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                 description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                 calories: 265,
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    login_as(user)
    visit(dish_path(9999))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Dish not found or you do not have access to this dish')
  end

  it 'and does not view dishes from other establishments' do
    bond = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    john = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    bond_estab = Establishment.create!(user: bond, corporate_name: 'Giraffas Brasil S.A.',
                                       brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                       email: 'contato@giraffas.com.br')

    john_estab = Establishment.create!(user: john, corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                       cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                       neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234', email: 'contato@kfc.com.br')

    dish = Dish.create!(establishment: john_estab, name: 'Pizza de Calabresa',
                 description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                 calories: 265,
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    login_as(bond)
    visit(dish_path(dish.id))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Dish not found or you do not have access to this dish')
  end

  it 'from the search' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                 description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                 calories: 265,
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'),
                 status: 'active')

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: 'Pizza'
    click_on('Search')
    click_on('Pizza de Calabresa')

    expect(page).to have_content('Pizza de Calabresa (Active)')
    expect(page).to have_content('Pizza com molho de tomate, queijo, calabresa e orégano')
    expect(page).to have_content('265 cal')
    expect(page).to have_css("img[src*='pizza-calabresa.jpg']")
  end
end
