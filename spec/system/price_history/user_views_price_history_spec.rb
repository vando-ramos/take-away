require 'rails_helper'

describe 'User views the price history' do
  it 'from the dish details page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')
    start_date = dish_option.created_at

    dish_option.update!(price: '20,00')
    end_date = dish_option.updated_at

    PriceHistory.create!(price: '30,00', start_date: start_date, end_date: end_date,
                         item_type: 'dish_option', item_id: dish_option.id)

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Price History')

    expect(current_path).to eq(dish_dish_price_history_index_path(dish.id))
    expect(page).to have_content('Price History')
    expect(page).to have_content('Média')
    expect(page).to have_content('R$30,00')
    expect(page).to have_content("De #{start_date.strftime("%d/%m/%Y %H:%M")} Até #{end_date.strftime("%d/%m/%Y %H:%M")}")
  end

  it 'and price history is empty' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Price History')

    expect(current_path).to eq(dish_dish_price_history_index_path(dish.id))
    expect(page).to have_content('Price History')
    expect(page).to have_content('There are no prices in the history')
  end

  it 'from the drink details page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: File.open(Rails.root.join('spec/fixtures/files/limonada.jpg')))

    drink_option = DrinkOption.create!(drink: drink, price: '10,00', description: '500ml')
    start_date = drink_option.created_at

    drink_option.update!(price: '15,00')
    end_date = drink_option.updated_at

    PriceHistory.create!(price: '10,00', start_date: start_date, end_date: end_date,
                         item_type: 'drink_option', item_id: drink_option.id)

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Price History')

    expect(current_path).to eq(drink_drink_price_history_index_path(drink.id))
    expect(page).to have_content('Price History')
    expect(page).to have_content('500ml')
    expect(page).to have_content('R$10,00')
    expect(page).to have_content("De #{start_date.strftime("%d/%m/%Y %H:%M")} Até #{end_date.strftime("%d/%m/%Y %H:%M")}")
  end

  it 'and the history is empty' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: File.open(Rails.root.join('spec/fixtures/files/limonada.jpg')))



    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Price History')

    expect(current_path).to eq(drink_drink_price_history_index_path(drink.id))
    expect(page).to have_content('Price History')
    expect(page).to have_content('There are no prices in the history')
  end
end
