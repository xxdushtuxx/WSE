class AddApplicableToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :applicable, :float
  end
end
