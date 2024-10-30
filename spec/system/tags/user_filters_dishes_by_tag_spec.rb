require 'rails_helper'

describe 'User filters dishes by tag' do
  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    tag_massa = Tag.create!(name: 'Massa')
    tag_vegano = Tag.create!(name: 'Vegano')
    tag_sem_gluten = Tag.create!(name: 'Sem Glúten')

    Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                 description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                 calories: 265, tags: [tag_massa], status: 'active',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    Dish.create!(establishment: estab, name: 'Macarrão Carbonara',
                 description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
                 calories: 550, tags: [tag_massa],
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/carbonara.jpg'), 'image/jpg'),
                 status: 'active')

    Dish.create!(establishment: estab,
                 name: 'Frango à Passarinho',
                 description: 'Frango em pedaços temperados e fritos até ficarem crocantes, servidos com limão',
                 calories: 500,
                 status: 'active',
                 image: fixture_file_upload(Rails.root.join('spec/fixtures/files/frango-a-passarinho.jpg'), 'image/jpg'),)

    login_as(user)
    visit(root_path)
    click_on('Dishes')
    select 'Massa', from: 'Filter by Tag'
    click_on 'Filter'

    expect(page).to have_content('Pizza de Calabresa')
    expect(page).to have_content('Macarrão Carbonara')
    expect(page).not_to have_content('Frango à Passarinho')
  end
end
