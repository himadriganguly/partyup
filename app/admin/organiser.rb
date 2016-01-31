ActiveAdmin.register Organiser do

  
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
   

  scope :unconfirmed
  
  index do
    selectable_column
    column :id
    column :email
    column "Requests", :organisers do |organiser|
      organiser.requests.count
    end
    column "Current Sign In At", :organisers do |organiser|
      organiser.current_sign_in_at.to_s.to_date.inspect
    end
    column :current_sign_in_ip
    column :last_sign_in_ip
    column "Confirmed", :organisers do |organiser|
      if (!organiser.confirmed_at.nil?)
        span :class=>"status_tag yes" do
          TRUE
        end
      else
        span :class=>"status_tag no" do
          FALSE
        end
      end
    end
    column :approved
    default_actions
  end
  
  filter :city
  filter :email
  filter :username
  filter :first_name
  filter :last_name
  filter :mobile
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :current_sign_in_ip
  filter :last_sign_in_ip
  filter :created_at
  filter :updated_at
  
   controller do
     
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
           
   end

  form do |f|
    f.inputs "Organiser Details" do
      f.input :email
      f.input :password, :required=>false
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :mobile
      f.input :city_id, :as => :select, :collection => City.all.map {|u| [u.name.upcase, u.id]}
      f.input :approved
    end
    f.actions
  end
   
  permit_params :approved,:first_name,:last_name,:email,:username,:mobile,:city_id,:password, :password_confirmation
    
end
