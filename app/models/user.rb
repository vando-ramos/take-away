class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :establishment, optional: true

  enum role: { normal: 0, admin: 1 }

  validates :establishment, presence: true, if: -> { normal? }
  validates :name, :last_name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, length: { is: 11 }, numericality: { only_integer: true }
  validate :valid_cpf

  before_validation :associate_with_establishment_if_pre_registered, if: -> { normal? }

  private

  def valid_cpf
    unless CPF.valid?(cpf)
      errors.add(:cpf, 'is not valid')
    end
  end

  def associate_with_establishment_if_pre_registered
    pre_registration = PreRegistration.find_by(email: email, cpf: cpf, status: :pending)

    if pre_registration
      self.establishment_id = pre_registration.establishment_id
      pre_registration.update(status: :used)
    else
      errors.add(:base, 'You need a pre-registration')
      throw(:abort)
    end
  end
end
