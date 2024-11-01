require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#valid' do
    it "name can't be black" do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      tag = Tag.new(name: '')

      expect(tag.valid?).to eq false
    end

    it 'and the tag must be unique' do
      user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                        email: 'bond@email.com', password: '123456abcdef',
                        password_confirmation: '123456abcdef')

      estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                    brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                    address: 'Rua Comercial Sul', number: '123',
                                    neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
                                    zip_code: '70300-902', phone_number: '2198765432',
                                    email: 'contato@giraffas.com.br')

      tag1 = Tag.create(name: 'Vegano')
      tag2 = Tag.new(name: 'Vegano')

      expect(tag2.valid?).to eq false
      expect(tag2.errors[:name]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it { should have_many(:dish_tags) }
    it { should have_many(:dishes) }
  end
end
