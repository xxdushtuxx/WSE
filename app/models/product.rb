class Product < ApplicationRecord
  belongs_to :category

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "sale_status", "stock", "updated_at"]
  end
end
