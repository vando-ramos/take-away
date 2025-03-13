class Menu < ApplicationRecord
  belongs_to :establishment
  has_many :menu_items
  has_many :items, through: :menu_items

  validates :name, presence: true
  validates :name, uniqueness: { scope: :establishment_id }
end
