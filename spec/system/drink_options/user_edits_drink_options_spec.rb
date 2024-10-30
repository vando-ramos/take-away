require 'rails_helper'

describe 'User edits drink options' do
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

    drink_option = DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Edit 300ml')

    expect(current_path).to eq(edit_establishment_drink_drink_option_path(estab.id, drink.id, drink_option.id))
    expect(page).to have_content('Edit Drink Option')
    expect(page).to have_field('Description', with: '300ml')
    expect(page).to have_field('Price', with: '5,00')
    expect(page).to have_button('Update Drink option')
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

    drink_option = DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Edit 300ml')
    fill_in 'Description', with: '500ml'
    fill_in 'Price', with: '8,00'
    click_on('Update Drink option')

    expect(current_path).to eq(establishment_drink_path(estab.id, drink.id))
    expect(page).to have_content('Drink option successfully updated')
    expect(page).to have_content('500ml')
    expect(page).to have_content('R$8,00')
  end

  it 'and the drink details not found' do
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

    drink_option = DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')

    login_as(user)
    visit(edit_establishment_drink_drink_option_path(estab.id, drink.id, 9999))

    expect(current_path).to eq(establishment_drink_path(estab.id, drink.id))
    expect(page).to have_content('Drink option not found')
  end
end
