class Organisers::SessionsController < Devise::SessionsController
  
  before_action :check_vendor, only: [:new]
  
  
  protected
  
  def check_vendor
    unless vendor_signed_in? || organiser_signed_in?
      return true
    else
      redirect_to authenticated_root_path
      return false
    end  
  end
  
end