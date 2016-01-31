class Dashboard::BaseController < ApplicationController
  
  before_action :check_user
  
  def index
    if organiser_signed_in?
      @organiser = current_organiser
      @requests = current_organiser.requests.where("cancel=?",0).order('created_at DESC').page(params[:page]).per(10)
    elsif vendor_signed_in?
      @vendor = current_vendor
      @proposals = current_vendor.proposals.order('created_at DESC').page(params[:page]).per(10) 
    end  
  end
  
  def edit_profile
    if organiser_signed_in?
      @user = Organiser.find(current_organiser.id)
    elsif vendor_signed_in?
      @user = Vendor.find(current_vendor.id) 
    end
  end
  
  def update_profile
    
    if organiser_signed_in?
      
      #https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password        
      
      organiser = Organiser.find(current_organiser.id)
                    
      if organiser_params[:password].blank?
        organiser_params.delete(:password)
        organiser_params.delete(:password_confirmation)
      end  
          
      successfully_updated = if needs_password?(organiser_params)
                               if organiser.update_attributes(organiser_params)
                                 flash[:notice] = "Successfully updated profile." 
                               else                              
                                session[:update_errors] = organiser.errors.full_messages                                                      
                               end                                                                    
                               sign_in organiser, :bypass => true 
                             else
                               if organiser.update_without_password(organiser_params)
                                flash[:notice] = "Successfully updated profile."
                               else                              
                                 session[:update_errors] = organiser.errors.full_messages
                               end
                               sign_in organiser, :bypass => true                             
                             end
  
      respond_to do |format|
        if successfully_updated        
          format.html { redirect_to dashboard_profile_path }
          format.json { head :no_content }
        else  
          format.html { redirect_to dashboard_profile_path }
          format.json { render json: organiser.errors, status: :unprocessable_entity }
        end
      end
      
    elsif vendor_signed_in?
      
      #https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password        
      
      @vendor = Vendor.find(current_vendor.id)
                    
      if vendor_params[:password].blank?
        vendor_params.delete(:password)
        vendor_params.delete(:password_confirmation)
      end  
          
      successfully_updated = if needs_password?(vendor_params)
                               if @vendor.update_attributes(vendor_params)
                                 flash[:notice] = "Successfully updated profile." 
                               else                              
                                session[:update_errors] = @vendor.errors.full_messages                                                      
                               end                                                                    
                               sign_in @vendor, :bypass => true 
                             else
                               if @vendor.update_without_password(vendor_params)
                                flash[:notice] = "Successfully updated profile."
                               else                              
                                 session[:update_errors] = @vendor.errors.full_messages
                               end
                               sign_in @vendor, :bypass => true                             
                             end
  
      respond_to do |format|
        if successfully_updated        
          format.html { redirect_to dashboard_profile_path }
          format.json { head :no_content }
        else  
          format.html { redirect_to dashboard_profile_path }
          format.json { render json: @vendor.errors, status: :unprocessable_entity }
        end
      end
    
    end
    
  end
  
  
  private
  
  def check_user
    unless organiser_signed_in? || vendor_signed_in?
      redirect_to organiser_session_path
      return false
    else
      return true
    end  
  end  
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def organiser_params
    params.require(:organiser).permit(:email, :password, :password_confirmation, :mobile, :avatar)
  end 
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def vendor_params
    params.require(:vendor).permit(:email, :password, :password_confirmation, :mobile, :avatar, vendor_profile_attributes: [:id, :vendor_id, :about, :skills, :youtubelink, :pic1, :pic2, :pic3, :pic4])
  end

  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  def needs_password?(params)
    params[:password].present? && params[:password_confirmation].present?
  end 
  
end
