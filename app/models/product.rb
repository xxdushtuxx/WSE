class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :category

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_status, inclusion: { in: ['yes', 'no'] }
  validates :category, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "sale_status", "stock", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "order_items", "orders"]
  end
end
