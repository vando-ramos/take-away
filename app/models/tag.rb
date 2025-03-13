class Tag < ApplicationRecord
  has_many :item_tags
  has_many :items, through: :item_tags

  validates :name, presence: true
  validates :name, uniqueness: true
end
