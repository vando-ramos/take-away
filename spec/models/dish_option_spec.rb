require 'rails_helper'

RSpec.describe DishOption, type: :model do
  describe 'associations' do
    it { should belong_to(:dish) }
    it { should have_many(:price_histories) }
  end

  describe '#valid' do
    it "Description can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265, status: 'active',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish_option = DishOption.new(dish: dish, price: '30,00', description: '')

    expect(dish_option.valid?).to eq false
    end

    it "Price can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    dish = Dish.create!(establishment: estab, name: 'Pizza de Calabresa',
                        description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
                        calories: 265, status: 'active',
                        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

    dish_option = DishOption.new(dish: dish, price: '', description: 'Média (26cm de diâmetro)')

    expect(dish_option.valid?).to eq false
    end
  end

  describe 'callbacks' do
    context 'when price is updated' do
      it 'create a price record' do
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
                            image: fixture_file_upload(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg'), 'image/jpg'))

        dish_option = DishOption.create!(dish: dish, price: '30,00', description: 'Média')
        start_date = dish_option.created_at

        dish_option.update!(price: '20,00')
        end_date = dish_option.updated_at

        price_history = PriceHistory.create!(price: '30,00', start_date: start_date, end_date: end_date,
                                             item_type: 'dish_option', item_id: dish_option.id)

        expect(price_history.price).to eq(30.00)
        expect(price_history.start_date).to eq(price_history.start_date)
        expect(price_history.end_date).to eq(price_history.end_date)
        expect(price_history.item_type).to eq('dish_option')
      end
    end
  end
end
