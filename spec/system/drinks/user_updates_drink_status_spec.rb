require 'rails_helper'

describe 'User updates the drink status' do
  it 'to inactive' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120,
                          is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'),
                          status: 'active')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Deactivate')

    expect(current_path).to eq(drink_path(drink.id))
    expect(page).to have_content('Drink successfully deactivated')
    expect(page).to have_content('Inactive')
    expect(page).to have_button('Activate')
    expect(page).not_to have_button('Deactivate')
  end

  it 'to active' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120,
                          is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'),
                          status: 'inactive')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Activate')

    expect(current_path).to eq(drink_path(drink.id))
    expect(page).to have_content('Drink successfully activated')
    expect(page).to have_content('Active')
    expect(page).to have_button('Deactivate')
    expect(page).not_to have_button('Activate')
  end
end
