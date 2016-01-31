ActiveAdmin.register ContactReason do

  
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
    column :reason
    column :created_at
    column :updated_at
    column "Contacts Posted", :contact_reason do |contact_reason|
      contact_reason.contacts.count
    end   
    default_actions
  end
  
  filter :reason
  filter :created_at
  filter :updated_at
  
  permit_params :reason
  
end
