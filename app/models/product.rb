class Product < ApplicationRecord
  belongs_to :category
=begin
  scope :on_sale, -> { where('price < ?', regular_price) }

  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }

  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago) }
=end
end
