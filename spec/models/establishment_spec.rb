require 'rails_helper'

RSpec.describe Establishment, type: :model do
  describe '#valid' do
    it "corporate name can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: '', brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "brand name can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: '', cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "cnpj can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: '',
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "address can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                address: '', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "number can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "neighborhood can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                          email: 'wick@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123', neighborhood: '', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "city can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                          email: 'wick@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                cnpj: CNPJ.generate, address: 'Rua Comercial Sul', number: '123',
                                neighborhood: 'Asa Sul', city: '', state: 'DF', zip_code: '70300-902',
                                phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "state can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: '', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "zip code can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "phone number can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it "email can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: '')

      expect(estab.valid?).to eq false
    end

    it "code can't be blank" do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                          email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq true
    end

    it 'cnpj must be valid' do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                          email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                cnpj: '00011100012345', address: 'Rua Comercial Sul', number: '123',
                                neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      expect(estab.valid?).to eq false
      expect(estab.errors[:cnpj]).to include("is not valid")
    end

    it 'cnpj must be unique' do
      bond = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                          email: 'bond@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      john = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                          email: 'wick@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      cnpj = CNPJ.generate

      estab1 = Establishment.create!(user: bond, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                     cnpj: cnpj, address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      estab2 = Establishment.new(user: john, corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC', cnpj: cnpj,
                                 address: 'Av Paulista', number: '1234', neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234',
                                 email: 'contato@kfc.com.br')

      expect(estab2.valid?).to eq false
    end

    it 'email must be valid' do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate,
                          email: 'wick@email.com', password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato.giraffas.com.br')

      expect(estab.valid?).to eq false
    end

    it 'phone number must be 10 or 11 digits' do
      user = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '98765432', email: 'contato@giraffas.com.br')

      estab.valid?

      expect(estab.errors.include? :phone_number).to be true
      expect(estab.errors[:phone_number]).to include('must be 10 or 11 digits')
    end
  end

  describe 'generates a random code' do
    it 'when register an establishment' do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab = Establishment.new(user: user, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                cnpj: CNPJ.generate,
                                address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      estab.save!
      result = estab.code

      expect(result).not_to be_empty
      expect(result.length).to eq(6)
    end

    it 'and the code must be unique' do
      bond = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate, email: 'bond@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      john = User.create!(name: 'John', last_name: 'Wick', identification_number: CPF.generate, email: 'wick@email.com',
                          password: '123456abcdef', password_confirmation: '123456abcdef')

      estab1 = Establishment.create!(user: bond, corporate_name: 'Giraffas Brasil S.A.', brand_name: 'Giraffas',
                                     cnpj: CNPJ.generate,
                                     address: 'Rua Comercial Sul', number: '123', neighborhood: 'Asa Sul', city: 'Brasília',
                                     state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

      estab2 = Establishment.new(user: john, corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
                                 cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
                                 neighborhood: 'Centro', city: 'São Paulo', state: 'SP', zip_code: '10010-100', phone_number: '1140041234', email: 'contato@kfc.com.br')

      estab2.save!

      expect(estab2.code).not_to eq(estab1.code)
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:operating_hours) }
    it { should have_many(:dishes) }
    it { should have_many(:drinks) }
    it { should have_many(:menus) }
    it { should have_many(:orders) }
  end
end
