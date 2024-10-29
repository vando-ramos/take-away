require 'rails_helper'

describe 'User views options' do
  it 'on the dish details page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265, status: 'active',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    DishOption.create!(dish: dish, price: '30,00', description: 'Média (26cm de diâmetro)')
    DishOption.create!(dish: dish, price: '50,00', description: 'Grande (35cm de diâmetro)')

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')

    expect(current_path).to eq(establishment_dish_path(estab.id, dish.id))
    expect(page).to have_content('Options')
    expect(page).to have_link('Register Dish Option')
    expect(page).to have_content('Média (26cm de diâmetro)')
    expect(page).to have_content('R$30,00')
    expect(page).to have_content('Grande (35cm de diâmetro)')
    expect(page).to have_content('R$50,00')
  end

  it 'on the drink details page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')
    DrinkOption.create!(drink: drink, price: '8,00', description: '500ml')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')

    expect(current_path).to eq(establishment_drink_path(estab.id, drink.id))
    expect(page).to have_content('Options')
    expect(page).to have_link('Register Drink Option')
    expect(page).to have_content('300ml')
    expect(page).to have_content('R$5,00')
    expect(page).to have_content('500ml')
    expect(page).to have_content('R$8,00')
  end

  it 'and there are no registered options for dishes' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265, status: 'active',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')

    expect(current_path).to eq(establishment_dish_path(estab.id, dish.id))
    expect(page).to have_content('Options')
    expect(page).to have_link('Register Dish Option')
    expect(page).to have_content('There are no registered dish options')
  end

  it 'and there are no registered options for drinks' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')

    expect(current_path).to eq(establishment_drink_path(estab.id, drink.id))
    expect(page).to have_content('Options')
    expect(page).to have_link('Register Drink Option')
    expect(page).to have_content('There are no registered drink options')
  end
end
