ActiveAdmin.register Category do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  index do
    selectable_column
    column :id
    column :name
    column :created_at
    column :updated_at
    column "Requests Posted", :category do |category|
      category.requests.count
    end
    default_actions
  end
  
  filter :name
  filter :created_at
  filter :updated_at
  
  permit_params :name
  
end