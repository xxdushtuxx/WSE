ActiveAdmin.register OrderItem do
    permit_params :order_id, :product_id, :quantity, :cost
  
    # Add any other columns you want to display in the index view
    index do
      selectable_column
      id_column
      column :order
      column :product
      column :quantity
      column :cost
      actions
    end
  
    # Add any other filters or search options you want
    filter :order
    filter :product
    filter :quantity
    filter :cost
  
    form do |f|
      f.inputs do
        f.input :order
        f.input :product
        f.input :quantity
        f.input :cost
      end
      f.actions
    end
  end
  