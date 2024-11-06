require 'rails_helper'

describe 'User edits tags' do
  it 'from the home page' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: File.open(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg')))

    dish.tags << Tag.create!(name: 'Vegano')
    dish.tags << Tag.create!(name: 'Sem Glúten')
    tag = dish.tags.first

    login_as(user)
    visit(root_path)
    click_on('My Establishment')
    click_on('Tags')
    find("#edit_tag_#{tag.id}").click

    expect(current_path).to eq(edit_establishment_tag_path(estab.id, tag.id))
    expect(page).to have_content('Edit Tag')
    expect(page).to have_field('Name', with: 'Vegano')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: File.open(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg')))

    dish.tags << Tag.create!(name: 'Vegano')
    dish.tags << Tag.create!(name: 'Sem Glúten')
    tag = dish.tags.first

    login_as(user)
    visit(root_path)
    click_on('My Establishment')
    click_on('Tags')
    find("#edit_tag_#{tag.id}").click
    fill_in 'Name', with: 'Vegetariano'
    click_on('Update Tag')

    expect(current_path).to eq(establishment_tags_path(estab.id))
    expect(page).to have_content('Tag successfully updated')
    expect(page).to have_content('Vegetariano')
  end

  it "and the name can't be blank" do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: File.open(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg')))

    dish.tags << Tag.create!(name: 'Vegano')
    dish.tags << Tag.create!(name: 'Sem Glúten')
    tag = dish.tags.first

    login_as(user)
    visit(root_path)
    click_on('My Establishment')
    click_on('Tags')
    find("#edit_tag_#{tag.id}").click
    fill_in 'Name', with: ''
    click_on('Update Tag')

    expect(page).to have_content('Unable to update tag')
    expect(page).to have_content("Name can't be blank")
  end

  it 'and only for their own establishment' do
    bond = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456789aaa',
                        password_confirmation: '123456789aaa')

    wick = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                        email: 'wick@email.com', password: '123456789aaa',
                        password_confirmation: '123456789aaa')

    estab1 = Establishment.create!(user: bond, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    estab2 = Establishment.create!(user: wick, corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                  cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                  neighborhood: 'Centro', city: 'São Paulo', state: 'SP',
                                  zip_code: '10010-100', phone_number: '1140041234',
                                  email: 'contato@kfc.com.br')

    dish = Dish.create!(establishment: estab2, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265,
                        image: File.open(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg')))

    dish.tags << Tag.create!(name: 'Vegano')
    tag = dish.tags.first

    login_as(bond)
    visit(edit_establishment_tag_path(estab2.id, tag.id))

    expect(current_path).to eq(establishment_tags_path(estab1.id))
    expect(page).to have_content('Not found or access not authorized')
  end
end
