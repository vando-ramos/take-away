class Establishment < ApplicationRecord
  belongs_to :user
  has_many :operating_hours
  has_many :dishes
  has_many :drinks
  has_many :menus
  has_many :orders
  has_many :pre_registrations

  validates :corporate_name, :brand_name, :cnpj, :address, :number, :neighborhood, :city, :state, :zip_code,
            :phone_number, :email, :code, presence: true
  validates :cnpj, uniqueness: true
  validate :valid_cnpj
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+(com|br|org)\z/, message: 'must be a valid email' }
  validates :phone_number, length: { in: 10..11, message: 'must be 10 or 11 digits' }

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
