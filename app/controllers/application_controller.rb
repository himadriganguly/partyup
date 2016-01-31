class ApplicationController < ActionController::Base
  
  include Pundit
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  add_flash_types :error
  add_flash_types :success
  
  # def after_sign_in_path_for(resource_or_scope)
    # if resource_or_scope.is_a?(Organiser)
      # authenticated_root_path
    # elsif resource_or_scope.is_a?(AdminUser) 
      # admin_dashboard_path(resource_or_scope)
    # end
  # end

  def after_sign_in_path_for(resource)
    case resource
      when Organiser then authenticated_root_path
      when Vendor then authenticated_root_path
      when AdminUser then admin_dashboard_path()
    end
  end


  
  def full_name_object(object)
    return object.first_name + " " + object.last_name
  end
  
  def get_city_id(data)
    city_id = City.find_by_name(data)
    city_id ? (return city_id.id) : (return nil)
  end
  
  def get_category_id(data)
    category_id = Category.find_by_name(data)
    category_id ? (return category_id.id) : (return nil)
  end
  
  def search_filter(param1,param2,model)
    
    category_id = get_category_id(param1)
    city_id = get_city_id(param2)
    
    if category_id.present? && city_id.present?
      if model==Vendor
        request = model.where(city: city_id, category: category_id).where("confirmed_at is not null").order('created_at DESC').page(params[:page]).per(24)
      else
        request = model.where(city: city_id, category: category_id).order('created_at DESC').page(params[:page]).per(24)
      end       
      category = param1
      city = param2
      return {:request=> request, :category=> category, :city=> city }
    elsif category_id.present? && city_id.blank?
      if model==Vendor
        request = model.where(category: category_id).where("confirmed_at is not null").order('created_at DESC').page(params[:page]).per(24) 
      else
        request = model.where(category: category_id).order('created_at DESC').page(params[:page]).per(24)
      end      
      category = param1
      city = "All City"
      return {:request=> request, :category=> category, :city=> city }
    elsif city_id.present? && category_id.blank?
      if model==Vendor
        request = model.where(city: city_id).where("confirmed_at is not null").order('created_at DESC').page(params[:page]).per(24)  
      else
        request = model.where(city: city_id).order('created_at DESC').page(params[:page]).per(24)
      end      
      category = "All"
      city = param2
      return {:request=> request, :category=> category, :city=> city } 
    elsif !(category_id.present?) && !(city_id.present?)
      if model==Vendor
        request = model.where("confirmed_at is not null").order('created_at DESC').page(params[:page]).per(24)
      else
        request = model.all.order('created_at DESC').page(params[:page]).per(24)
      end      
      category = "All"
      city = "All City" 
      return {:request=> request, :category=> category, :city=> city } 
    end
    
  end
  
  def vendor_emails(request)
    
    vendors = Vendor.where("category_id=? AND city_id=? AND confirmed_at is not null",request.category_id,request.city_id)
        
    emails = vendors.to_a.map{|value| ["email",value.email, "name",value.first_name+" "+value.last_name,"type","to"]}
    
    emails.map! do |arr|
      hash = {}
      arr.each_slice(2) do |key, val|
        hash[key] = val
      end
      hash
    end
    
    return emails
    
  end
  
  def related_vendor_emails(request)
    
    vendors = request.vendors
        
    emails = vendors.to_a.map{|value| ["email",value.email, "name",value.first_name+" "+value.last_name,"type","to"]}
    
    emails.map! do |arr|
      hash = {}
      arr.each_slice(2) do |key, val|
        hash[key] = val
      end
      hash
    end
    
    return emails
    
  end
  
   
  private
  
   def user_not_authorized
    render :file => "#{Rails.root}/public/404.html",  :status => 404
    #flash[:error] = "You are not authorized to perform this action. Or there is no such page you want to access."
    #redirect_to(request.referrer || root_path)
  end
          
end
