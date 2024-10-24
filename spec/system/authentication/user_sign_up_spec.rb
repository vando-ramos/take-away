require 'rails_helper'

describe 'User sign up' do
  it 'successfully' do
    visit(root_path)
    click_on('Sign up')
    fill_in 'Name', with: 'James'
    fill_in 'Last name', with: 'Bond'
    fill_in 'Identification number', with: CPF.generate
    fill_in 'Email', with: 'bond@email.com'
    fill_in 'Password', with: '123456abcdef'
    fill_in 'Password confirmation', with: '123456abcdef'
    within('form') do
      click_on('Sign up')
    end

    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
    within('nav') do
      expect(page).to have_button('Sign out')
      expect(page).to have_content('bond@email.com')
    end
    expect(page).to have_content('Welcome! You have signed up successfully')
  end
end
