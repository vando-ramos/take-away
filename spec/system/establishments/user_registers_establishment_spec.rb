require 'rails_helper'

describe 'User registers an establishment' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'after authentication is redirected to the new establishment page' do
    user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(new_establishment_path)

    expect(page).to have_content('Please register your establishment')
    expect(page).to have_field('Corporate name')
    expect(page).to have_field('Brand name')
    expect(page).to have_field('Cnpj')
    expect(page).to have_field('Address')
    expect(page).to have_field('Neighborhood')
    expect(page).to have_field('City')
    expect(page).to have_field('State')
    expect(page).to have_field('Zip code')
    expect(page).to have_field('Phone number')
    expect(page).to have_field('Email')
    expect(page).to have_button('Save')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    cnpj = CNPJ.generate

    login_as(user)
    visit(new_establishment_path)
    fill_in 'Corporate name', with: 'Giraffas Brasil S.A.'
    fill_in 'Brand name', with: 'Giraffas'
    fill_in 'Cnpj', with: cnpj
    fill_in 'Address', with: 'Rua Comercial Sul'
    fill_in 'Number', with: '123'
    fill_in 'Neighborhood', with: 'Asa Sul'
    fill_in 'City', with: 'Brasília'
    fill_in 'State', with: 'DF'
    fill_in 'Zip code', with: '70300-902'
    fill_in 'Phone number', with: '2198765432'
    fill_in 'Email', with: 'contato@giraffas.com.br'
    click_on 'Save'

    expect(page).to have_content('Establishment successfully registered')
    expect(page).to have_content('My Establishment')
    expect(page).to have_content('Giraffas Brasil S.A.')
    expect(page).to have_content('Giraffas')
    expect(page).to have_content(cnpj)
    expect(page).to have_content('Rua Comercial Sul, 123 - Asa Sul - Brasília - DF - CEP: 70300-902')
    expect(page).to have_content('2198765432')
    expect(page).to have_content('contato@giraffas.com.br')
  end

  it 'with icomplete data' do
    user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(new_establishment_path)
    fill_in 'Corporate name', with: ''
    fill_in 'Brand name', with: ''
    fill_in 'Cnpj', with: ''
    fill_in 'Phone number', with: ''
    fill_in 'Email', with: ''
    click_on 'Save'

    expect(page).to have_content('Unable to register establishment')
    expect(page).to have_content("Corporate name can't be blank")
    expect(page).to have_content("Brand name can't be blank")
    expect(page).to have_content("Cnpj can't be blank")
    expect(page).to have_content("Phone number can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

  it 'and a user can only has one establishment' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(new_establishment_path)

    expect(current_path).to eq(establishments_path)
    expect(page).to have_content('You already have an establishment')
  end
end
