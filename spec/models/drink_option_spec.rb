require 'rails_helper'

RSpec.describe DrinkOption, type: :model do
  describe 'associations' do
    it { should belong_to(:drink) }
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

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink_option = DrinkOption.new(drink: drink, price: '5,00', description: '')

    expect(drink_option.valid?).to eq false
    end

    it "Price can't be blank" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com',
                        password: '123456abcdef', password_confirmation: '123456abcdef')

    estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                  cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                  neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

    drink = Drink.create!(establishment: estab, name: 'Limonada',
                          description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                          calories: 120, is_alcoholic: 'no', status: 'active',
                          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/limonada.jpg'), 'image/jpg'))

    drink_option = DrinkOption.new(drink: drink, price: '', description: '300ml')

    expect(drink_option.valid?).to eq false
    end
  end

  describe 'callbacks' do
    context 'when price is updated' do
      it 'create a price record' do
        user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                            email: 'bond@email.com', password: '123456abcdef',
                            password_confirmation: '123456abcdef')

        estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                      cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                      neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

        drink = Drink.create!(establishment: estab, name: 'Limonada',
                                      description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
                                      calories: 120, is_alcoholic: 'no', status: 'active',
                                      image: File.open(Rails.root.join('spec/fixtures/files/limonada.jpg')))

        drink_option = DrinkOption.create!(drink: drink, price: '10,00', description: '500ml')
        start_date = drink_option.created_at

        drink_option.update!(price: '15,00')
        end_date = drink_option.updated_at

        price_history = PriceHistory.create!(price: '10,00', start_date: start_date, end_date: end_date,
                                             item_type: 'drink_option', item_id: drink_option.id)

        expect(price_history.price).to eq(10.00)
        expect(price_history.start_date).to eq(price_history.start_date)
        expect(price_history.end_date).to eq(price_history.end_date)
        expect(price_history.item_type).to eq('drink_option')
      end
    end
  end
end
