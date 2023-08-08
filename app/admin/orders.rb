ActiveAdmin.register Order do
  permit_params :customer_id, :total_price, :status, :tax, :province_id

  # Add any other columns you want to display in the index view
  index do
    selectable_column
    id_column
    column :customer
    column :status
    column :province
    column :hst
    column :gst
    column :pst
    column :tax
    column :sub_total
    column :total_price
    actions
  end

  # Add any other filters or search options you want
  filter :customer
  filter :total_price
  filter :status
  filter :tax

  form do |f|
    f.inputs do
      f.input :customer
      f.input :total_price
      f.input :sub_total
      f.input :status, as: :select, collection: ['new', 'paid', 'shipped']
      f.input :province_id, as: :select, collection: Province.all.map { |province| [province.name, province.id] }, prompt: 'Select Province'
      f.input :hst
      f.input :gst
      f.input :pst
      f.input :tax
    end
    f.actions
  end
end
