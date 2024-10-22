require 'rails_helper'

describe 'User sign up' do
  it 'successfully' do
    visit(root_path)
    within('nav') do
      click_on('Sign in')
    end
    click_on('Sign up')
    fill_in 'Name', with: 'James'
    fill_in 'Last name', with: 'Bond'
    fill_in 'Identification number', with: '111.222.333-44'
    fill_in 'Email', with: 'bond@email.com'
    fill_in 'Password', with: '123456abcdef'
    fill_in 'Password confirmation', with: '123456abcdef'
    click_on('Sign up')

    within('nav') do
      expect(page).not_to have_link('Sign in')
      expect(page).to have_button('Sign out')
      expect(page).to have_content('bond@email.com')
    end
    expect(page).to have_content('Welcome! You have signed up successfully')
  end
end
