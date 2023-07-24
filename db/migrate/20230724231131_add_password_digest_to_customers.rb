class AddPasswordDigestToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :password_digest, :string
  end
end
