class AddProvinceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :province, :string
  end
end
