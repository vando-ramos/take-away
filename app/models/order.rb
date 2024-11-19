class Order < ApplicationRecord
  belongs_to :establishment
  has_many :order_dishes, dependent: :destroy
  has_many :dishes, through: :order_dishes
  has_many :order_drinks, dependent: :destroy
  has_many :drinks, through: :order_drinks

  validates :customer_name, presence: true
  validates :customer_phone, presence: true, unless: -> { customer_email.present? }
  validates :customer_email, presence: true, unless: -> { customer_phone.present? }
  validates :customer_email, format: { with: /\A[^@\s]+@([^@\s]+\.)+(com|br|org)\z/,
              message: 'must be a valid email' }, allow_blank: true
  validate :valid_cpf

  before_validation :generate_code, on: :create

  enum status: { awaiting_kitchen_confirmation: 0, in_preparation: 1, canceled: 2,
                 ready: 3, delivered: 4 }

  def total_price
    total_dishes = order_dishes.sum(&:total_price)
    total_drinks = order_drinks.sum(&:total_price)

    total_dishes + total_drinks
  end

  def update_total_value!
    self.update!(total_value: total_price)
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def valid_cpf
    unless CPF.valid?(customer_cpf)
      errors.add(:customer_cpf, 'is not valid')
    end
  end
end
