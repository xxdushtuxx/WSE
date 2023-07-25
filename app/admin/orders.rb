ActiveAdmin.register Order do
  permit_params :customer_id, :total_price

  index do
    selectable_column
    id_column
    column :customer
    column :total_price
    actions
  end

  filter :customer
  filter :total_price

  form do |f|
    f.inputs 'Order Details' do
      f.input :customer
      f.input :total_price
    end
    f.actions
  end
end
