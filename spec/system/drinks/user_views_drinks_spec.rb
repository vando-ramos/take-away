require 'rails_helper'

describe 'User views the drinks' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    Drink.create!(establishment: estab, name: 'Limonada',
                 description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                 calories: 120, is_alcoholic: 'no',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    Drink.create!(establishment: estab, name: 'Mojito',
                 description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                 calories: 150, is_alcoholic: 'yes',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')

    expect(current_path).to eq(establishment_drinks_path(estab.id))
    expect(page).to have_content('Drinks')
    expect(page).to have_content('Limonada')
    expect(page).to have_content('Uma refrescante bebida feita com limões frescos, açúcar e água')
    expect(page).to have_content('120 cal')
    expect(page).to have_css("img[src*='limonada.jpg']")
    expect(page).to have_content('Mojito')
    expect(page).to have_content('Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás')
    expect(page).to have_content('150 cal')
    expect(page).to have_css("img[src*='mojito.jpg']")
  end

  it 'and there is no drinks registered' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902',
                                  phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('Drinks')

    expect(current_path).to eq(establishment_drinks_path(estab.id))
    expect(page).to have_content('Drinks')
    expect(page).to have_content('There is no drinks registered')
  end

  it 'and the drink not found' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    Drink.create!(establishment: estab, name: 'Limonada',
                  description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                  calories: 120, is_alcoholic: 'no',
                  image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(establishment_drink_path(estab.id, 9999))

    expect(current_path).to eq(establishment_drinks_path(estab.id))
    expect(page).to have_content('Drink not found')
  end

  it 'and does not view drinks from other establishments' do
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

    drink = Drink.create!(establishment: john_estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(bond)
    visit(establishment_drink_path(john_estab.id, drink.id))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You do not have access to drinks from other establishments')
  end
end
