require 'rails_helper'

describe 'User registers the operating hours' do
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

    login_as(user)
    visit(root_path)
    click_on('Operating Hours')
    click_on('Register Operating Hour')

    expect(current_path).to eq(new_establishment_operating_hour_path(estab.id))
    expect(page).to have_content('Register Operating Hour')
    expect(page).to have_field('Day of week')
    expect(page).to have_content('Opening time')
    expect(page).to have_select('operating_hour_opening_time_4i')
    expect(page).to have_select('operating_hour_opening_time_5i')
    expect(page).to have_content('Closing time')
    expect(page).to have_select('operating_hour_closing_time_4i')
    expect(page).to have_select('operating_hour_closing_time_5i')
    expect(page).to have_field('Status')
    expect(page).to have_button('Create Operating hour')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)
    click_on('Operating Hours')
    click_on('Register Operating Hour')
    select 'Sunday', from: 'Day of week'
    select '08', from: 'operating_hour_opening_time_4i'
    select '00', from: 'operating_hour_opening_time_5i'
    select '17', from: 'operating_hour_closing_time_4i'
    select '00', from: 'operating_hour_closing_time_5i'
    select 'Opened', from: 'Status'
    click_on('Create Operating hour')

    expect(current_path).to eq(establishment_operating_hours_path(estab.id))
    expect(page).to have_content('Operating hour successfully registered')
    expect(page).to have_content('Sunday')
    expect(page).to have_content('08:00 - 17:00')
  end
end
