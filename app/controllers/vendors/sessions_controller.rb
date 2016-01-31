class Vendors::SessionsController < Devise::SessionsController
  
  before_action :check_organiser, only: [:new]
  
  
  protected
  
  def check_organiser
    unless vendor_signed_in? || organiser_signed_in?
      return true
    else
      redirect_to authenticated_root_path
      return false
    end  
  end
  
end