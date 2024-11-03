require 'rails_helper'

describe 'User edits the operating hours' do
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

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    OperatingHour.day_of_weeks.keys.each do |day|
      OperatingHour.create!(establishment: estab, day_of_week: day, opening_time: '08:00', closing_time: '17:00', status: 'opened')
    end

    login_as(user)
    visit(root_path)
    click_on('Sunday')
    click_on('Edit')

    expect(page).to have_content('Edit Sunday')
    expect(page).to have_select('Day of week', with_options: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'])
    expect(page).to have_select('operating_hour_opening_time_4i', selected: '08')
    expect(page).to have_select('operating_hour_opening_time_5i', selected: '00')
    expect(page).to have_select('operating_hour_closing_time_4i', selected: '17')
    expect(page).to have_select('operating_hour_closing_time_5i', selected: '00')
    expect(page).to have_select('Status', with_options: ['Opened', 'Closed'])
    expect(page).to have_button('Update Operating hour')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    OperatingHour.day_of_weeks.keys.each do |day|
      OperatingHour.create!(establishment: estab, day_of_week: day, opening_time: '08:00', closing_time: '17:00', status: 'opened')
    end

    login_as(user)
    visit(root_path)
    click_on('Sunday')
    click_on('Edit')
    select '09', from: 'operating_hour_opening_time_4i'
    select '30', from: 'operating_hour_opening_time_5i'
    select '16', from: 'operating_hour_closing_time_4i'
    select '30', from: 'operating_hour_closing_time_5i'
    click_on('Update Operating hour')

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Operating hour successfully updated')
    expect(page).to have_content('Sunday')
    expect(page).to have_content('09:30 - 16:30')
  end
end
