require 'rails_helper'

describe 'User updates the dish status' do
  it 'to inactive' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'),
                        status: 'active')

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Deactivate')

    expect(current_path).to eq(establishment_dish_path(estab.id, dish.id))
    expect(page).to have_content('Dish successfully deactivated')
    expect(page).to have_content('Inactive')
    expect(page).to have_button('Activate')
    expect(page).not_to have_button('Deactivate')
  end

  # it 'to active' do
  # end
end
