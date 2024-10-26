describe 'User edits dishes' do
  it 'if authenticated' do
    visit(root_path)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'from menu' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Edit')

    expect(current_path).to eq(edit_establishment_drink_path(estab.id, drink.id))
    expect(page).to have_content('Edit Drink')
    expect(page).to have_field('Name', with: 'Limonada')
    expect(page).to have_field('Description', with: 'Uma refrescante bebida feita com limões frescos, açúcar e água')
    expect(page).to have_field('Calories', with: '120')
    expect(page).to have_select('Is alcoholic', with_options: ['Yes', 'No'])
    expect(page).to have_field('Image', type: 'file')
    expect(page).to have_button('Update Drink')
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Edit')
    fill_in 'Name', with: 'Mojito'
    fill_in 'Description', with: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás'
    fill_in 'Calories', with: '150'
    select 'Yes', from: 'Is alcoholic'
    attach_file('Image', Rails.root.join('spec/fixtures/files/mojito.jpg'))
    click_on('Update Drink')

    expect(current_path).to eq(establishment_drinks_path(estab.id))
    expect(page).to have_content('Drink successfully updated')
    expect(page).to have_content('Mojito')
    expect(page).to have_content('Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás')
    expect(page).to have_content('150 cal')
    expect(page).to have_content('Is alcoholic? Yes')
    expect(page).to have_css("img[src*='mojito.jpg']")
  end

  it 'successfully' do
    user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    login_as(user)
    visit(root_path)
    click_on('Drinks')
    click_on('Limonada')
    click_on('Edit')
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    fill_in 'Calories', with: ''
    click_on('Update Drink')

    expect(page).to have_content('Unable to update drink')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Calories can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end
