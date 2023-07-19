class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :authentication_password

      t.timestamps
    end
  end
end
