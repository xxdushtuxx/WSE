class Order < ApplicationRecord
  belongs_to :customer
  has_many :products, through: :order_items

  validates :customer_id, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "customer_id", "total_price", "created_at", "updated_at"]
  end
end
