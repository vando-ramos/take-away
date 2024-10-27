require 'rails_helper'

describe 'User visits the establishment page' do
  it 'if athenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'and views their establishment information'  do
    cnpj = CNPJ.generate
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    establishment = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: cnpj,
                                          address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                          state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('My Establishment')

    expect(current_path).to eq(establishment_path(establishment.id))
    expect(page).to have_content('My Establishment')
    expect(page).to have_content('Giraffas Brasil S.A.')
    expect(page).to have_content('Giraffas')
    expect(page).to have_content(cnpj)
    expect(page).to have_content('Rua Comercial Sul, 123 - Asa Sul - Brasília - DF - CEP: 70300-902')
    expect(page).to have_content('2198765432')
    expect(page).to have_content('contato@giraffas.com.br')
  end

  it 'and does not view others establishments' do
    bond = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    john = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab1 = Establishment.create!(user: bond, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                   cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                   neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    estab2 = Establishment.create!(user: john, corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                   cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                   neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234', email: 'contato@kfc.com.br')

    login_as(john)
    visit(establishment_path(estab1.id))

    expect(current_path).not_to eq(establishment_path(estab1.id))
    expect(current_path).to eq(root_path)
    expect(page).to have_content('You do not have access to other establishments')
    expect(page).not_to have_content('Giraffas Brasil S.A.')
    expect(page).not_to have_content('Giraffas')
    expect(page).not_to have_content('2198765432')
    expect(page).not_to have_content('contato@giraffas.com.br')
  end

  it 'and there is no registered establishment' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    login_as(user)
    visit(root_path)

    expect(current_path).to eq(new_establishment_path)
    expect(page).to have_content('Please register an establishment')
  end

  it 'and the establishment not found' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(establishment_path(9999))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Establishment not found')
  end
end
