class Option < ApplicationRecord
  belongs_to :dish, optional: true
  belongs_to :drink, optional: true

  # validate :must_have_dish_or_drink

  private

  # def must_have_dish_or_drink
  #   unless dish.present? || drink.present?
  #     errors.add(:base, 'Must have a drink or dish')
  #   end
  # end
end
