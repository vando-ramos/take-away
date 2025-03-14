require 'rails_helper'

describe 'User edits drink options' do
  it 'from the drink details page' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink_option = DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    find("#edit_drink_option_#{drink_option.id}").click

    expect(current_path).to eq(edit_drink_drink_option_path(drink.id, drink_option.id))
    expect(page).to have_content('Edit Drink Option')
    expect(page).to have_field('Description', with: '300ml')
    expect(page).to have_field('Price', with: 'R$5,00')
    expect(page).to have_button('Update Drink option')
  end

  it 'successfully' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink_option = DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    find("#edit_drink_option_#{drink_option.id}").click
    fill_in 'Description', with: '500ml'
    fill_in 'Price', with: '8,00'
    click_on('Update Drink option')

    expect(current_path).to eq(drink_path(drink.id))
    expect(page).to have_content('Drink option successfully updated')
    expect(page).to have_content('500ml')
    expect(page).to have_content('R$8,00')
  end

  it 'and the drink details not found' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink_option = DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')

    login_as(user)
    visit(edit_drink_drink_option_path(drink.id, 9999))

    expect(current_path).to eq(drink_path(drink.id))
    expect(page).to have_content('Drink option not found')
  end
end
