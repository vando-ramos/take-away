class PreRegistration < ApplicationRecord
  belongs_to :establishment

  enum status: { pending: 0, used: 1 }
end
