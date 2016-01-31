class Vendors::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_action :check_organiser, only: [:new]
  
  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
      flash.delete :recaptcha_error
      render :new
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name,:last_name,:email,:business_name,:est_year,:category_id,:city_id,:username,:mobile,:password,:password_confirmation) }
  end
  
  def check_organiser
    unless vendor_signed_in? || organiser_signed_in?
      return true
    else
      redirect_to authenticated_root_path
      return false
    end  
  end

end
