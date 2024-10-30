require 'rails_helper'

describe 'User views dish options' do
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

  it 'and there are no registered dish options' do
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
end
