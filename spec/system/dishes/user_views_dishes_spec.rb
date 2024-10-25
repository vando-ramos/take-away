require 'rails_helper'

describe 'User views the dishes' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                 description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                 calories: 265,
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                 description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                 calories: 550,
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Dishes')

    expect(current_path).to eq(establishment_dishes_path(estab.id))
    expect(page).to have_content('Dishes')
    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('Pizza com molho de tomate, queijo, calabresa e orégano')
    expect(page).to have_content('265 cal')
    expect(page).to have_css("img[src*='pizza-calabresa.jpg']")
    expect(page).to have_content('Macarrão Carbonara')
    expect(page).to have_content('Macarrão com molho cremoso à base de ovos, queijo e bacon')
    expect(page).to have_content('550 cal')
    expect(page).to have_css("img[src*='carbonara.jpg']")
  end

  it 'and there is no dishes registered' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902',
                                  phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('Dishes')

    expect(current_path).to eq(establishment_dishes_path(estab.id))
    expect(page).to have_content('Dishes')
    expect(page).to have_content('There is no dishes registered')
  end
end
