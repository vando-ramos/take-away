require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    User.create!(name: 'James', last_name: 'Bond', identification_number: '111.222.333-44', email: 'bond@email.com',
                 password: '123456abcdef', password_confirmation: '123456abcdef')

    visit(root_path)
    within('nav') do
      click_on('Sign in')
    end
    fill_in 'Email', with: 'bond@email.com'
    fill_in 'Password', with: '123456abcdef'
    within('form') do
      click_on('Sign in')
    end

    within('nav') do
      expect(page).not_to have_link('Sign in')
      expect(page).to have_button('Sign out')
      expect(page).to have_content('bond@email.com')
    end
    expect(page).to have_content('Signed in successfully')
  end

  it 'and sign out' do
    User.create!(name: 'James', last_name: 'Bond', identification_number: '111.222.333-44', email: 'bond@email.com',
                 password: '123456abcdef', password_confirmation: '123456abcdef')

    visit(root_path)
    within('nav') do
      click_on('Sign in')
    end
    fill_in 'Email', with: 'bond@email.com'
    fill_in 'Password', with: '123456abcdef'
    within('form') do
      click_on('Sign in')
    end
    within('nav') do
      click_on('Sign out')
    end

    within('nav') do
      expect(page).to have_link('Sign in')
      expect(page).not_to have_button('Sign out')
      expect(page).not_to have_content('bond@email.com')
    end
    expect(page).to have_content('Signed out successfully')
  end
end
