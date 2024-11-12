require 'rails_helper'

describe 'User views the drinks' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    Drink.create!(establishment: estab, name: 'Limonada',
                 description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                 calories: 120, is_alcoholic: 'no', status: 'active',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    Drink.create!(establishment: estab, name: 'Mojito',
                 description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                 calories: 150, is_alcoholic: 'yes', status: 'inactive',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')

    expect(current_path).to eq(drinks_path)
    expect(page).to have_content('Drinks')
    expect(page).to have_content('Limonada (Active)')
    expect(page).to have_content('Uma refrescante bebida feita com limões frescos, açúcar e água')
    expect(page).to have_content('120 cal')
    expect(page).to have_content('Is alcoholic? No')
    expect(page).to have_css("img[src*='limonada.jpg']")
    expect(page).to have_content('Mojito (Inactive)')
    expect(page).to have_content('Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás')
    expect(page).to have_content('150 cal')
    expect(page).to have_content('Is alcoholic? Yes')
    expect(page).to have_css("img[src*='mojito.jpg']")
  end

  it 'and there is no drinks registered' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902',
                                  phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(root_path)
    click_on('Drinks')

    expect(current_path).to eq(drinks_path)
    expect(page).to have_content('Drinks')
    expect(page).to have_content('There is no drinks registered')
  end

  it 'and the drink not found' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    Drink.create!(establishment: estab, name: 'Limonada',
                  description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                  calories: 120, is_alcoholic: 'no',
                  image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(drink_path(9999))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Drink not found or you do not have access to this drink')
  end

  it 'and does not view drinks from other establishments' do
    bond_estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                       brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                       email: 'contato@giraffas.com.br')

    john_estab = Establishment.create!(corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                       cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                       neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234', email: 'contato@kfc.com.br')

    bond = User.create!(establishment: bond_estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    john = User.create!(establishment: john_estab, name: 'John', last_name: 'Wick', cpf: CPF.generate,
                        email: 'wick@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: john_estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(bond)
    visit(drink_path(drink.id))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Drink not found or you do not have access to this drink')
  end

  it 'from the search' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    Drink.create!(establishment: estab, name: 'Limonada',
                  description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                  calories: 120, is_alcoholic: 'no', status: 'active',
                  image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: 'Limonada'
    click_on('Search')
    click_on('Limonada')

    expect(page).to have_content('Limonada (Active)')
    expect(page).to have_content('Uma refrescante bebida feita com limões frescos, açúcar e água')
    expect(page).to have_content('120 cal')
    expect(page).to have_content('Is alcoholic? No')
    expect(page).to have_css("img[src*='limonada.jpg']")
  end
end
