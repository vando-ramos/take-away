require 'rails_helper'

describe 'Admin pre registers new users' do
  it 'if athenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from home page' do
    user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul',
                                  number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                  state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user.update!(establishment: estab)

    login_as(user)
    visit(root_path)
    click_on('Users')
    click_on('Register User')

    expect(current_path).to eq(new_pre_registration_path)
    expect(page).to have_content('Register User')
    expect(page).to have_field('Email')
    expect(page).to have_field('Cpf')
    expect(page).to have_button('Create User')
  end

  it 'successfully' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul',
                                  number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                  state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    cpf = CPF.generate
    login_as(user)
    visit(root_path)
    click_on('Users')
    click_on('Register User')
    fill_in 'Email', with: 'wick@email.com'
    fill_in 'Cpf', with: cpf
    click_on('Create User')

    expect(current_path).to eq(pre_registrations_path)
    expect(page).to have_content('User successfully registered')
    expect(page).to have_content('Users')
    expect(page).to have_content('wick@email.com')
    expect(page).to have_content(cpf)
    expect(page).to have_content('Pending')
  end
end
