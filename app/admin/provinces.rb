# app/admin/provinces.rb

ActiveAdmin.register Province do
  permit_params :name, :pst, :hst, :gst, :applicable

  # Customize the form inputs for create and edit actions
  form do |f|
    f.inputs 'Province Details' do
      f.input :name
      f.input :pst
      f.input :hst
      f.input :gst
      f.input :applicable
    end
    f.actions
  end

  # Customize the index view with pagination
  index do
    selectable_column
    id_column
    column :name
    column :pst
    column :hst
    column :gst
    column :applicable
    actions
  end
end
