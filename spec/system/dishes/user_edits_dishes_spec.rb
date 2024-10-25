require 'rails_helper'

describe 'User edits dishes' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from menu' do
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
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Edit')

    expect(current_path).to eq(edit_establishment_dish_path(estab.id, dish.id))
    expect(page).to have_content('Edit Dish')
    expect(page).to have_field('Name', with: 'Pizza de Calabresa')
    expect(page).to have_field('Description', with: 'Pizza com molho de tomate, queijo, calabresa e orégano')
    expect(page).to have_field('Calories', with: '265')
    expect(page).to have_field('Image', type: 'file')
    expect(page).to have_button('Update Dish')
  end

  it 'successfully' do
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
    click_on('Dishes')
    click_on('Pizza de Calabresa')
    click_on('Edit')
    fill_in 'Name', with: 'Macarrão Carbonara'
    fill_in 'Description', with: 'Macarrão com molho cremoso à base de ovos, queijo e bacon'
    fill_in 'Calories', with: '550'
    attach_file('Image', Rails.root.join('spec/fixtures/files/carbonara.jpg'))
    click_on('Update Dish')

    expect(current_path).to eq(establishment_dishes_path(estab.id))
    expect(page).to have_content('Dish successfully updated')
    expect(page).to have_content('Macarrão Carbonara')
    expect(page).to have_content('Macarrão com molho cremoso à base de ovos, queijo e bacon')
    expect(page).to have_content('550 cal')
    expect(page).to have_css("img[src*='carbonara.jpg']")
  end
end
