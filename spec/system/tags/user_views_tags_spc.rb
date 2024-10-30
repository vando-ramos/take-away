require 'rails_helper'

describe 'User views tags' do
  it 'from the menu' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                  zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    Tag.create!(name: 'Vegano')
    Tag.create!(name: 'Sem glúten')
    Tag.create!(name: 'Diet')

    login_as(user)
    visit(root_path)
    click_on('Tags')

    expect(current_path).to eq(establishment_tags_path(estab.id))
    expect(page).to have_content('Tags')
    expect(page).to have_content('#Vegano')
    expect(page).to have_content('#Sem glúten')
    expect(page).to have_content('#Diet')
  end

  it 'and there are no registered tags' do
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
    click_on('Tags')

    expect(current_path).to eq(establishment_tags_path(estab.id))
    expect(page).to have_content('Tags')
    expect(page).to have_content('There are no registered tags')
  end
end
