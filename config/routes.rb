Rails.application.routes.draw do
   
  get 'dashboard' => 'dashboard/base#index', as: :authenticated_root
  
  
  # ****** Proposal Routes ******
  
  get 'requests/:id/proposal' => "proposals#new", as: :new_request_proposal 
      
  resource :proposals, only: [:create, :edit, :update]  
  
  patch 'proposals/award'
  put 'proposals/award'
  
  # ****** End of Proposal Routes ******
  
  
  # ****** Clarification Routes ******
  
  get 'requests/:id/clarification' => "clarifications#new", as: :new_request_clarification
    
  resource :clarifications, only: [:create]
  
  # ****** End of Clarification Routes ******
  
  
  # ****** Favourites Routes ******
  
  resources :favourites, only: [:create, :destroy]
  
  scope '/dashboard' do
    resources :favourites, only: [:index], as: :dashboard_favourites
  end
  
  # ****** End of Favourites Routes ******
  
  
  # ****** Dashboard Routes ******
  
  namespace :dashboard do
      
      #Request Actions
      resource :requests, only: [:new, :create, :edit, :update]      
      get 'requests/:id/delete' => "requests#delete", as: :request_delete     
      post 'requests/cancel', as: :request_cancel     
      post 'requests/vendor_invite'
            
      #Profile Actions
      get 'profile' => "base#edit_profile"
      patch 'base/update_profile'
      put 'base/update_profile'
      
      #Highlight Actions
      resources :highlights, except: [:show]    
      get 'highlights/:id/delete' => "highlights#delete"
            
  end
  
  resources :requests, module: 'dashboard', only: [:index, :show] 
  
  # ****** End of Dashboard Routes ******
  
  # Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # Devise for Vendors
  devise_for :vendors, controllers: { sessions: "vendors/sessions" }, skip: :registrations, :path=>"vendor", :path_names => {:sign_in => 'signin', :sign_out => 'logout'}
  devise_scope :vendor do
    get "vendor/register" => "vendors/registrations#new", as: :new_vendor_registration
    resource :registration,
      only: [:create],
      path: 'vendor',
      #path_names: { new: 'register' },
      controller: 'vendors/registrations',
      as: :vendor_registration
  end
  
  # Devise for Organisers  
  devise_for :organisers, controllers: { sessions: "organisers/sessions" }, skip: :registrations, :path=>"", :path_names => {:new=>'register',:sign_in => 'signin', :sign_out => 'logout'} 
  devise_scope :organiser do
    get "register" => "organisers/registrations#new", as: :new_organiser_registration
    resource :registration,
      only: [:create],
      path: 'organiser',
      #path_names: { new: 'register' },
      controller: 'organisers/registrations',
      as: :organiser_registration
  end
  
  # Contact Form
  get 'contact' => "contacts#new", as: :new_contact
  post 'contacts'=> "contacts#create"
  
  # Organiser details
  get 'organisers/:username' => "welcome#organiser_show", as: :organiser_details
  
  # Vendor details
  get 'vendors/:username' => "welcome#vendor_show", as: :vendor_details
  
  # Vendor list
  get 'vendors' => "welcome#vendor_list"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  
end
