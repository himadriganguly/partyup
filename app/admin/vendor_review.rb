ActiveAdmin.register VendorReview do

  
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
    column :request_title
    column :organiser
    column :quality
    column :service
    column :created_at
    column :updated_at   
    default_actions
  end
  
  permit_params :request_title,:request_venue,:organiser,:date,:quality,:service,:vendor_id,:created_at,:updated_at,:comment
  
end
