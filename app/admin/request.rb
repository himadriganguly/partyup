ActiveAdmin.register Request do

  
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
  
  scope :requests_cancel
  
  index do
    selectable_column
    column :id
    column :title
    column :budget
    column :date
    column "Proposals", :requests do |request|
      request.proposals.count
    end
    column :cancel
    column :created_at, :sort_order=> :created_at_desc
    column :updated_at
    default_actions
  end
  
  filter :city
  filter :category
  filter :organiser
  filter :vendors
  filter :title
  filter :venue
  filter :hours
  filter :budget
  filter :guests
  filter :date
  filter :created_at
  filter :updated_at
  filter :accept_proposal
  filter :vendor_select
  filter :cancel
  
  permit_params :title,:city_id,:venue,:category_id,:hours,:budget,:guests,:date,:time,:description
  
end