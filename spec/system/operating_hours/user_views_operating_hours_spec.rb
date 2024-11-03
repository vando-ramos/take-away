require 'rails_helper'

describe "User views the establishment's operating hours" do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from the menu' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                  state: 'DF', zip_code: '70300-902', phone_number: '2198765432',
                                  email: 'contato@giraffas.com.br')

    OperatingHour.day_of_weeks.keys.each do |day|
      OperatingHour.create!(establishment: estab, day_of_week: day, opening_time: '10:00', closing_time: '17:00')
    end

    login_as(user)
    visit(root_path)

    expect(page).to have_content('Operating Hours')
    expect(page).to have_content('Sunday')
    expect(page).to have_content('10:00 - 17:00')
    expect(page).to have_content('Monday')
    expect(page).to have_content('10:00 - 17:00')
    expect(page).to have_content('Tuesday')
    expect(page).to have_content('10:00 - 17:00')
    expect(page).to have_content('Wednesday')
    expect(page).to have_content('10:00 - 17:00')
    expect(page).to have_content('Thursday')
    expect(page).to have_content('10:00 - 17:00')
    expect(page).to have_content('Friday')
    expect(page).to have_content('10:00 - 17:00')
    expect(page).to have_content('Saturday')
    expect(page).to have_content('10:00 - 17:00')
  end

  it 'and there is no operating hours registered' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                  brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                  address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul',
                                  city: 'Brasília', state: 'DF', zip_code: '70300-902',
                                  phone_number: '2198765432', email: 'contato@giraffas.com.br')

    login_as(user)
    visit(root_path)

    expect(page).to have_content('Operating Hours')
    expect(page).to have_content('There is no operating hours registered')
  end

  it 'and the establishment not found' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902',
                                  phone_number: '2198765432', email: 'contato@giraffas.com.br')

    OperatingHour.day_of_weeks.keys.each do |day|
      OperatingHour.create!(establishment: estab, day_of_week: day, opening_time: '10:00', closing_time: '17:00')
    end

    login_as(user)
    visit(establishment_operating_hour_path(estab.id, 9999))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Operating hour not found')
  end
end
