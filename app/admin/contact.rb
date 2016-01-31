ActiveAdmin.register Contact do

  
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
  
  scope :not_replied
  
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :replied
    column :created_at
    column :updated_at
    default_actions
  end
  
  filter :contact_reason, :collection=>proc{(ContactReason.all).map{|c| [c.reason,c.id]}}
  filter :name
  filter :email
  filter :created_at
  filter :updated_at
  filter :replied
  
  form do |f|
    f.inputs "Edit Contact" do
      f.input :contact_reason, :collection=>(ContactReason.all).map{|c| [c.reason,c.id]}
      f.input :name
      f.input :email
      f.input :comment
      f.input :replied     
    end
    f.actions
  end
  
  permit_params :replied
  
end
