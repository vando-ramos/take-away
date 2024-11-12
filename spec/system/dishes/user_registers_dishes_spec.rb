require 'rails_helper'

describe 'User registers dishes' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Register Dish')

    expect(current_path).to eq(new_dish_path)
    expect(page).to have_content('Register Dish')
    expect(page).to have_field('Name')
    expect(page).to have_field('Description')
    expect(page).to have_field('Calories')
    expect(page).to have_field('Image', type: 'file')
    expect(page).to have_button('Create Dish')
  end

  it 'successfully' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')



    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Register Dish')
    fill_in 'Name', with: 'Pizza de Calabresa'
    fill_in 'Calories', with: 256
    fill_in 'Description', with: 'Pizza com molho de tomate, queijo, calabresa e orégano'
    attach_file('Image', Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'))
    click_on('Create Dish')

    expect(current_path).to eq(dishes_path)
    expect(page).to have_content('Dish successfully registered')
    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('256 cal')
    expect(page).to have_content('Pizza com molho de tomate, queijo, calabresa e orégano')
    expect(page).to have_css("img[src*='pizza-calabresa.jpg']")
  end

  it 'and all fields are mandatory' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')



    login_as(user)
    visit(root_path)
    click_on('Dishes')
    click_on('Register Dish')
    fill_in 'Name', with: ''
    fill_in 'Calories', with: ''
    fill_in 'Description', with: ''
    click_on('Create Dish')

    expect(page).to have_content('Unable to register dish')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Calories can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Image can't be blank")
  end
end
