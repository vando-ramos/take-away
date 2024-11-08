class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :establishment
  has_many :orders

  validates :name, :last_name, :identification_number, presence: true
  validates :identification_number, uniqueness: true
  validates :identification_number, length: { is: 11 }, numericality: { only_integer: true }
  validate :valid_cpf

  private

  def valid_cpf
    unless CPF.valid?(identification_number)
      errors.add(:identification_number, 'is not valid')
    end
  end
end
