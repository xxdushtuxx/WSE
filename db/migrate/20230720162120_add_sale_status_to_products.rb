class AddSaleStatusToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :sale_status, :string
  end
end
