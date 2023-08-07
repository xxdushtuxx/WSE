class RemoveProvinceFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :province, :string
  end
end
