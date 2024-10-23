class Establishment < ApplicationRecord
  belongs_to :user

  validates :corporate_name, :brand_name, :cnpj, :address, :number, :neighborhood, :city, :state, :zip_code,
            :phone_number, :email, :code, presence: true

  validate :valid_cnpj

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end

  def valid_cnpj
    unless CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'is not valid')
    end
  end
end
