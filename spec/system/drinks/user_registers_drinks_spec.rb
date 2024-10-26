require 'rails_helper'

describe 'User registers drinks' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Register Drink')

    expect(current_path).to eq(new_establishment_drink_path(estab.id))
    expect(page).to have_content('Register Drink')
    expect(page).to have_field('Name')
    expect(page).to have_field('Description')
    expect(page).to have_field('Calories')
    expect(page).to have_field('Is alcoholic')
    expect(page).to have_field('Image', type: 'file')
    expect(page).to have_button('Create Drink')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Register Drink')
    fill_in 'Name', with: 'Limonada'
    fill_in 'Calories', with: 120
    select 'No', from: 'Is alcoholic'
    fill_in 'Description', with: 'Uma refrescante bebida feita com limões frescos, açúcar e água'
    attach_file('Image', Rails.root.join('spec/fixtures/files/limonada.jpg'))
    click_on('Create Drink')

    expect(current_path).to eq(establishment_drinks_path(estab.id))
    expect(page).to have_content('Drink successfully registered')
    expect(page).to have_content('Limonada')
    expect(page).to have_content('120 cal')
    expect(page).to have_content('Is alcoholic? No')
    expect(page).to have_content('Uma refrescante bebida feita com limões frescos, açúcar e água')
    expect(page).to have_css("img[src*='limonada.jpg']")
  end

  it 'and all fields are mandatory' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Register Drink')
    fill_in 'Name', with: ''
    fill_in 'Calories', with: ''
    fill_in 'Description', with: ''
    click_on('Create Drink')

    expect(page).to have_content('Unable to register drink')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Calories can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Image can't be blank")
  end
end
