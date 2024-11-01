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

    expect(current_path).to eq(establishment_dish_dish_price_history_index_path(estab.id, dish.id))
    expect(page).to have_content('Price History')
    expect(page).to have_content('Média')
    expect(page).to have_content('R$30,00')
    expect(page).to have_content("De #{start_date.strftime("%d/%m/%Y %H:%M")} Até #{end_date.strftime("%d/%m/%Y %H:%M")}")
  end
end
