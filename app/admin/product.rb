# app/admin/product.rb
ActiveAdmin.register Product do
    # Permit necessary attributes for CRUD actions
    permit_params :name, :description, :stock, :price, :sale_status, :category_id
  
    # Customize the form inputs for create and edit actions
    form do |f|
      f.inputs 'Product Details' do
        f.input :name
        f.input :description
        f.input :stock
        f.input :price
        f.input :sale_status, as: :select, collection: ['yes', 'no']
        f.input :category_id, as: :select, collection: Category.all
      end
      f.actions
    end
  end
  