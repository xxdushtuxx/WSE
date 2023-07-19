class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.integer :stock
      t.decimal :price

      t.timestamps
    end
  end
end
