require 'rails_helper'

describe 'User adds tags to dishes' do
  it 'when edit a dish' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    Tag.create!(name: 'Vegano')
    Tag.create!(name: 'Sem Glúten')
    Tag.create!(name: 'Diet')

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Edit')
    check 'Vegano'
    check 'Sem Glúten'
    check 'Diet'
    click_on('Update Dish')

    expect(current_path).to eq(dishes_path)
    expect(page).to have_content('Dish successfully updated')
    expect(page).to have_content('#Vegano')
    expect(page).to have_content('#Sem Glúten')
    expect(page).to have_content('#Diet')
  end
end
