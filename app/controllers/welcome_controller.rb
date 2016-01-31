class WelcomeController < ApplicationController
  
  before_action :login_user?, only: [ :index ]
  
  def index
    
  end
  
  def organiser_show
    @organiser = Organiser.find_by_username(params[:username])
    @requests = @organiser.requests.page(params[:page]).per(10)
  end
  
  def vendor_show
    @vendor = Vendor.find_by_username(params[:username])
    if organiser_signed_in? && current_organiser.requests.count > 0 
      @requests = current_organiser.requests.where("vendor_select=? AND cancel=? AND date > ?",0,0,Time.now.to_date).order("created_at DESC")
    end
  end
  
  def vendor_list
    
    result = search_filter(params[:category],params[:city],Vendor)
    
    @vendor = result[:request]
    
    if organiser_signed_in? && current_organiser.requests.count > 0 
      @requests = current_organiser.requests.where("vendor_select=? AND cancel=? AND date > ?",0,0,Time.now.to_date).order("created_at DESC")
    end
    
    if (result[:category] == "All") 
      @category = "All Vendors"
    else
      @category = result[:category]
    end    
    @city = result[:city]
    
  end
  
  private
  
  def login_user?
    unless organiser_signed_in? || vendor_signed_in?
      return true
    else
      redirect_to :controller=>"dashboard/base", :action=>"index"
    end  
  end
  
end
