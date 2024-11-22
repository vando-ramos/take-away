class PreRegistration < ApplicationRecord
  belongs_to :establishment

  validates :cpf, :email, presence: true

  enum status: { pending: 0, used: 1 }

  def translated_status
    I18n.t("activerecord.attributes.pre_registration.statuses.#{status}")
  end
end
