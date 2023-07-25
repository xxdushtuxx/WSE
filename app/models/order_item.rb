class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, :quantity, :cost, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }
end
