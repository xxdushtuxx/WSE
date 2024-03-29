ActiveAdmin.register Category do
  #actions :index, :edit, :update, :create, :destroy

  # Permit necessary attributes for CRUD actions
  permit_params :name, :description

  # Customize the form inputs for create and edit actions
  form do |f|
    f.inputs 'Category Details' do
      f.input :name
      f.input :description
    end
    f.actions
  end

end
