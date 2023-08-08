class AddTaxColumnsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :gst, :decimal, precision: 10, scale: 2
    add_column :orders, :pst, :decimal, precision: 10, scale: 2
    add_column :orders, :hst, :decimal, precision: 10, scale: 2
  end
end
