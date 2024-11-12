require 'rails_helper'

describe 'User register tags' do
  it 'from the home page' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(root_path)
    click_on('My Establishment')
    click_on('Tags')
    click_on('Add Tag')

    expect(current_path).to eq(new_establishment_tag_path(estab.id))
    expect(page).to have_content('New Tag')
    expect(page).to have_field('Name')
    expect(page).to have_button('Create Tag')
  end

  it 'sucessfully' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(root_path)
    click_on('My Establishment')
    click_on('Tags')
    click_on('Add Tag')
    fill_in 'Name', with: 'Vegano'
    click_on('Create Tag')

    expect(current_path).to eq(establishment_tags_path(estab.id))
    expect(page).to have_content('Tags')
    expect(page).to have_content('Vegano')
  end

  it "and the name can't be blank" do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    login_as(user)
    visit(root_path)
    click_on('My Establishment')
    click_on('Tags')
    click_on('Add Tag')
    fill_in 'Name', with: ''
    click_on('Create Tag')

    expect(page).to have_content('Unable to register tag')
    expect(page).to have_content("Name can't be blank")
  end
end
