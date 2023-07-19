# db/migrate/20230719150000_rename_authentication_password_to_password_digest_in_admins.rb
class RenameAuthenticationPasswordToPasswordDigestInAdmins < ActiveRecord::Migration[6.0]
  def change
    rename_column :admins, :authentication_password, :password_digest
  end
end
