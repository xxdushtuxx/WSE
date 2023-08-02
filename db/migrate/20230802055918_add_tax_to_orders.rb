class AddTaxToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :tax, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
