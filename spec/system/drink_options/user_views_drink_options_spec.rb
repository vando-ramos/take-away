require 'rails_helper'

describe 'User views drink options' do
  it 'on the drink details page' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    DrinkOption.create!(drink: drink, price: '5,00', description: '300ml')
    DrinkOption.create!(drink: drink, price: '8,00', description: '500ml')

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')

    expect(current_path).to eq(drink_path(drink.id))
    expect(page).to have_content('Options')
    expect(page).to have_link('Register Drink Option')
    expect(page).to have_content('300ml')
    expect(page).to have_content('R$5,00')
    expect(page).to have_content('500ml')
    expect(page).to have_content('R$8,00')
  end

  it 'and there are no registered drink options' do
    estab = Establishment.create!(corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    user = User.create!(establishment: estab, name: 'James', last_name: 'Bond', cpf: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef', role: 'admin')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')

    expect(current_path).to eq(drink_path(drink.id))
    expect(page).to have_content('Options')
    expect(page).to have_link('Register Drink Option')
    expect(page).to have_content('There are no registered drink options')
  end
end
