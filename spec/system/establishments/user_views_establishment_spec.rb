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
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: cnpj, address: 'Rua Comercial Sul',
                                  number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                  state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(root_path)
    click_on('My Establishment')
    click_on('Giraffas Brasil S.A.')

    expect(current_path).to eq(establishment_path(estab.id))
    expect(page).to have_content('My Establishment')
    expect(page).to have_content('Giraffas Brasil S.A.')
    expect(page).to have_content('Giraffas')
    expect(page).to have_content(cnpj)
    expect(page).to have_content('Rua Comercial Sul, 123 - Asa Sul - Brasília - DF - CEP: 70300-902')
    expect(page).to have_content('2198765432')
    expect(page).to have_content('contato@giraffas.com.br')
  end

  it 'and does not view others establishments' do
    bond_estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                   cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                   neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    john_estab = Establishment.create!(corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                   cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                   neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234', email: 'contato@kfc.com.br')

    bond = User.create!(establishment: bond_estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    john = User.create!(establishment: john_estab, name: 'John', last_name: 'Wick', cpf: CPF.generate,
                        email: 'wick@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(john)
    visit(establishment_path(bond_estab.id))

    expect(current_path).not_to eq(establishment_path(bond_estab.id))
    expect(current_path).to eq(establishments_path)
    expect(page).to have_content('Establishment not found or you do not have access')
    expect(page).not_to have_content('Giraffas Brasil S.A.')
    expect(page).not_to have_content('Giraffas')
    expect(page).not_to have_content('2198765432')
    expect(page).not_to have_content('contato@giraffas.com.br')
  end

  it 'and there is no registered establishment' do
    user = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(new_establishment_path)

    expect(page).to have_content('Please register your establishment')
  end

  it 'and the establishment not found' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(establishment_path(9999))

    expect(current_path).to eq(establishments_path)
    expect(page).to have_content('Establishment not found or you do not have access')
  end
end
