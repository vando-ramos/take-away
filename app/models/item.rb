class Item < ApplicationRecord
  belongs_to :establishment
  has_one_attached :image
  has_many :options, as: :optionable, dependent: :destroy
  has_many :menu_items
  has_many :menus, through: :menu_items
  has_many :order_drinks
  has_many :orders, through: :order_drinks
  has_many :item_tags
  has_many :tags, through: :item_tags

  enum is_alcoholic: { yes: 0, no: 1 }
  enum status: { active: 0, inactive: 1 }

  validates :name, :description, :calories, :image, presence: true

  def translated_is_alcoholic
    I18n.t("activerecord.attributes.item.is_alcoholics.#{is_alcoholic}")
  end

  def translated_status
    I18n.t("activerecord.attributes.item.statuses.#{status}")
  end
end
