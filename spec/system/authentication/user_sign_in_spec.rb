require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate, email: 'bond@email.com',
                 password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    visit(root_path)
    fill_in 'Email', with: 'bond@email.com'
    fill_in 'Password', with: '123456abcdef'
    click_on('Sign in')

    expect(page).not_to have_link('Sign in')
    within('nav') do
      expect(page).to have_button('Sign out')
      expect(page).to have_content('bond@email.com')
    end
    expect(page).to have_content('Signed in successfully')
  end

  it 'and sign out' do
    User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate, email: 'bond@email.com',
                 password: '123456abcdef', password_confirmation: '123456abcdef', role: 'admin')

    visit(root_path)
    fill_in 'Email', with: 'bond@email.com'
    fill_in 'Password', with: '123456abcdef'
    click_on('Sign in')
    within('nav') do
      click_on('Sign out')
    end

    expect(current_path).to eq(new_user_session_path)
    within('nav') do
      expect(page).not_to have_button('Sign out')
      expect(page).not_to have_content('bond@email.com')
    end
  end
end
