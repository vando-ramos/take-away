class Option < ApplicationRecord
  belongs_to :dish, optional: true
  belongs_to :drink, optional: true
end
