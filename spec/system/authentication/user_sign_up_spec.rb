require 'rails_helper'

describe 'User sign up' do
  # user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
  #                       email: 'bond@email.com', password: '123456abcdef',
  #                       password_confirmation: '123456abcdef', role: 'admin')

  estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul',
                                  number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                  state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

  cpf = CPF.generate
  pre_registration = PreRegistration.create!(establishment: estab, email: 'wick@email.com', cpf: cpf)

  it 'successfully' do
    visit(root_path)
    click_on('Sign up')
    fill_in 'Name', with: 'John'
    fill_in 'Last name', with: 'Wick'
    fill_in 'Cpf', with: cpf
    fill_in 'Email', with: 'wick@email.com'
    fill_in 'Password', with: '123456abcdef'
    fill_in 'Password confirmation', with: '123456abcdef'
    within('form') do
      click_on('Sign up')
    end

    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
    within('nav') do
      expect(page).to have_button('Sign out')
      expect(page).to have_content('wick@email.com')
    end
    expect(page).to have_content('Welcome! You have signed up successfully')
  end
end
