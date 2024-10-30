require 'rails_helper'

describe 'User edits dish options' do
  it 'from the dish details page' do
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

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média (26cm)')

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Edit Média (26cm)')

    expect(current_path).to eq(edit_establishment_dish_dish_option_path(estab.id, dish.id, dish_option.id))
    expect(page).to have_content('Edit Dish Option')
    expect(page).to have_field('Description', with: 'Média (26cm)')
    expect(page).to have_field('Price', with: '30,00')
    expect(page).to have_button('Update Dish option')
  end

  it 'successfully' do
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

    dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média (26cm)')

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Edit Média (26cm)')
    fill_in 'Description', with: 'Pequena (15cm)'
    fill_in 'Price', with: '20,00'
    click_on('Update Dish option')

    expect(current_path).to eq(establishment_dish_path(estab.id, dish.id))
    expect(page).to have_content('Dish option successfully updated')
    expect(page).to have_content('Pequena (15cm)')
    expect(page).to have_content('R$20,00')
  end
end
