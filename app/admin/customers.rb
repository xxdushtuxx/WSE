ActiveAdmin.register Customer do
  permit_params :province_id, :first_name, :last_name, :email, :phone, :address, :city, :postal_code, :password_digest

  form do |f|
    f.semantic_errors # This line will display error messages on top of the form if there are any validation errors.
    f.inputs 'Customer Details' do
      f.input :province_id, as: :select, collection: Province.all, include_blank: false # Assuming you have a Province model with a 'name' attribute.
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :password_digest
    end
    f.actions
  end
end
