require 'rails_helper'

describe 'User searches for dishes and drinks' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the any page' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(root_path)

    expect(page).to have_field('Search')
    expect(page).to have_button('Search')
  end

  it 'and finds a dish by name' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.co.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

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
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

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
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

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
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

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

  it 'and finds multiple dishes' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    dish1 = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish2 = Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                         description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                         calories: 550,
                         image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: 'queijo'
    click_on('Search')

    expect(page).to have_content("Results found: 2")
    expect(page).to have_content("#{dish1.name}")
    expect(page).to have_content("#{dish2.name}")
  end

  it 'and finds multiple drinks' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    drink1 = Drink.create!(establishment: estab, name: 'Limonada',
                           description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                           calories: 120, is_alcoholic: 'no',
                           image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink2 = Drink.create!(establishment: estab, name: 'Mojito',
                           description: 'Um coquetel clássico cubano feito com rum branco, limões, hortelã, açúcar e água com gás',
                           calories: 150, is_alcoholic: 'yes',
                           image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: 'limões'
    click_on('Search')

    expect(page).to have_content("Results found: 2")
    expect(page).to have_content("#{drink1.name}")
    expect(page).to have_content("#{drink2.name}")
  end

  it 'and does not find dishes from other establishments' do
    bond_estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    john_estab = Establishment.create!(corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                  cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                  neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234', email: 'contato@kfc.com.br')

    bond = User.create!(establishment: bond_estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    john = User.create!(establishment: john_estab, name: 'John', last_name: 'Wick', cpf: CPF.generate,
                        email: 'wick@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    dish1 = Dish.create!(establishment: bond_estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish2 = Dish.create!(establishment: john_estab, name: 'Macarrão Carbonara',
                         description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                         calories: 550,
                         image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    login_as(john)
    visit(root_path)
    fill_in 'Search', with: 'queijo'
    click_on('Search')

    expect(page).to have_content("Results found: 1")
    expect(page).to have_content("#{dish2.name}")
    expect(page).not_to have_content("#{dish1.name}")
  end

  it 'and does not find drinks from other establishments' do
    bond_estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                   cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    john_estab = Establishment.create!(corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                  cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                  neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234', email: 'contato@kfc.com.br')

    bond = User.create!(establishment: bond_estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    john = User.create!(establishment: john_estab, name: 'John', last_name: 'Wick', cpf: CPF.generate,
                        email: 'wick@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    drink1 = Drink.create!(establishment: bond_estab, name: 'Limonada',
                           description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                           calories: 120, is_alcoholic: 'no',
                           image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink2 = Drink.create!(establishment: john_estab, name: 'Mojito',
                           description: 'Um coquetel clássico cubano feito com rum branco, limões, hortelã, açúcar e água com gás',
                           calories: 150, is_alcoholic: 'yes',
                           image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    login_as(john)
    visit(root_path)
    fill_in 'Search', with: 'limões'
    click_on('Search')

    expect(page).to have_content("Results found: 1")
    expect(page).to have_content("#{drink2.name}")
    expect(page).not_to have_content("#{drink1.name}")
  end

  it 'and dish and drink not found' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    drink = Drink.create!(establishment: estab, name: 'Mojito',
                           description: 'Um coquetel clássico cubano feito com rum branco, limões, hortelã, açúcar e água com gás',
                           calories: 150, is_alcoholic: 'yes',
                           image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    fill_in 'Search', with: 'Suco de manjericão'
    click_on('Search')

    expect(page).to have_content("Results found: 0")
    expect(page).to have_content("Dish not found")
    expect(page).to have_content("Drink not found")
    expect(page).not_to have_content("#{dish.name}")
    expect(page).not_to have_content("#{drink.name}")
  end
end
