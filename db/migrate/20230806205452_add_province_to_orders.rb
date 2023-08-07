class AddProvinceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :province, null: false, foreign_key: true, null: true
  end
end
