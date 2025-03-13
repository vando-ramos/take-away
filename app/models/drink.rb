class Drink < Item
  validates :is_alcoholic, presence: true
end
