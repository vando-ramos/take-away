require 'rails_helper'

describe 'User searches for dishes and drinks' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the navbar' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    login_as(user)
    visit(root_path)

    within('nav') do
      expect(page).to have_field('Search')
      expect(page).to have_button('Search')
    end
  end

  it 'and finds a dish by name' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: dish.name
    click_on('Search')

    expect(page).to have_content("Results found: 1")
    expect(page).to have_content("#{dish.name}")
  end

  it 'and finds a dish by description' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: dish.description
    click_on('Search')

    expect(page).to have_content("Results found: 1")
    expect(page).to have_content("#{dish.name}")
  end

  it 'and find a drink by name' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                 description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                 calories: 120, is_alcoholic: 'no',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: drink.name
    click_on('Search')

    expect(page).to have_content("Results found: 1")
    expect(page).to have_content("#{drink.name}")
  end

  it 'and find a drink by description' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                 description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                 calories: 120, is_alcoholic: 'no',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: drink.description
    click_on('Search')

    expect(page).to have_content("Results found: 1")
    expect(page).to have_content("#{drink.name}")
  end
end
