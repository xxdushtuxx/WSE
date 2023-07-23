ActiveAdmin.register Category do
  actions :index, :edit, :update, :create, :destroy

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

  # Customize the index view with pagination
  index do
    selectable_column
    id_column
    column :name
    column :description
    actions
  end

  # Ensure the collection is paginated properly for the index action
  controller do
    before_action do
      params[:page] ||= 1 if request.format == 'text/html'
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "updated_at"]
  end
end
