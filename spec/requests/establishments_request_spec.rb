require 'rails_helper'

RSpec.describe "Establishments", type: :request do
  describe "GET /establishments/new" do
    context 'when user already has an establishment' do
      it "redirect to root_path" do
        user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                            email: 'bond@email.com', password: '123456abcdef',
                            password_confirmation: '123456abcdef')

        estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                      brand_name: 'Giraffas', cnpj:CNPJ.generate,
                                      address: 'Rua Comercial Sul', number: '123',
                                      neighborhood: 'Asa Sul', city: 'Brasília',
                                      state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

        login_as(user)

        get new_establishment_path
        expect(response).to redirect_to(establishments_path)
        follow_redirect!
        expect(flash[:alert]).to eq('You already have an establishment')
      end
    end
  end

  describe "POST /establishments" do
    context 'when user already has an establishment' do
      it "redirect to root_path" do
        user = User.create!(name: 'James', last_name: 'Bond', identification_number: CPF.generate,
                             email: 'bond@email.com', password: '123456abcdef',
                             password_confirmation: '123456abcdef')

        estab = Establishment.create!(user: user, corporate_name: 'Giraffas Brasil S.A.',
                                        brand_name: 'Giraffas', cnpj: CNPJ.generate,
                                        address: 'Rua Comercial Sul', number: '123',
                                        neighborhood: 'Asa Sul', city: 'Brasília',
                                        state: 'DF', zip_code: '70300-902', phone_number: '2198765432', email: 'contato@giraffas.com.br')

        login_as(user)

        establishment_params = {
          establishment: {
            corporate_name: 'New Establishment S.A.',
            brand_name: 'New Brand',
            cnpj: CNPJ.generate,
            address: 'New Address',
            number: '456',
            neighborhood: 'New Neighborhood',
            city: 'New City',
            state: 'New State',
            zip_code: '00000-000',
            phone_number: '2198765432',
            email: 'new_contact@example.com'
          }
        }

        post establishments_path, params: establishment_params

        expect(response).to redirect_to(establishments_path)
        follow_redirect!
        expect(flash[:alert]).to eq('You already have an establishment')
        expect(Establishment.count).to eq(1)
      end
    end
  end
end
