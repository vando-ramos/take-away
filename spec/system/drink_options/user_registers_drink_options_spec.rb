require 'rails_helper'

describe 'User registers drink options' do
  it 'from the drink details page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Register Drink Option')

    expect(current_path).to eq(new_drink_drink_option_path(drink.id))
    expect(page).to have_content('Register Drink Option')
    expect(page).to have_field('Description')
    expect(page).to have_field('Price')
    expect(page).to have_button('Create Drink option')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Register Drink Option')
    fill_in 'Description', with: '300ml'
    fill_in 'Price', with: '5,00'
    click_on('Create Drink option')

    expect(current_path).to eq(drink_path(drink.id))
    expect(page).to have_content('Register Drink Option')
    expect(page).to have_content('Drink option successfully registered')
    expect(page).to have_content('300ml')
    expect(page).to have_content('R$5,00')
  end

  it 'and all fields are mandatory' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Register Drink Option')
    fill_in 'Description', with: ''
    fill_in 'Price', with: ''
    click_on('Create Drink option')

    expect(page).to have_content('Unable to register drink option')
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Price can't be blank")
  end
end
