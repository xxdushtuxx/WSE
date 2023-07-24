class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.float :pst
      t.float :hst
      t.float :gst

      t.timestamps
    end
  end
end
