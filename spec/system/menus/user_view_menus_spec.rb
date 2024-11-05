require 'rails_helper'

describe 'User views the menus' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'on the home page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    dish1 = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish2 = Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                        description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                        calories: 550,
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    drink1 = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink2 = Drink.create!(establishment: estab, name: 'Mojito',
                          description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
                          calories: 150, is_alcoholic: 'yes',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/mojito.jpg'), 'image/jpg'))

    Menu.create!(establishment: estab, name: 'Lunch', dishes: [dish1, dish2])
    Menu.create!(establishment: estab, name: 'Drinks', drinks: [drink1, drink2])

    login_as(user)
    visit(root_path)

    expect(page).to have_content('Menus')
    expect(page).to have_link('Lunch')
    expect(page).to have_link('Drinks')
  end

  it 'and there are not registered menus' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)

    expect(page).to have_content('Menus')
    expect(page).to have_content('There are not registered menus')
  end
end
