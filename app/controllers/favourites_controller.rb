class FavouritesController < ApplicationController  
  
  before_action :authenticate_vendor!
  
  after_action :verify_authorized, only: [:destroy]
  
  def index
    
    @favourite = Favourite.where("vendor_id=?",current_vendor.id).order('created_at DESC').page(params[:page]).per(10)
    
  end
   
  def create
      
      @fav = Favourite.new(favourite_params)
            
      @fav.request_id = params[:request_id]
      @fav.vendor_id = current_vendor.id     
      
      if @result=@fav.save
        respond_to do |format|
          format.html {
              flash[:success] = "Request has been successfully added to your favourite."
              redirect_to :back
          }
          format.js{@result,@id = @fav.id}
        end
      else
        respond_to do |format|
          format.html {
              flash[:success] = "Error prevent the request to be added to the favourite."
              redirect_to :back
          }
          format.js{}
        end
      end
 
    
  end
  
  def destroy
    
    @fav = Favourite.where("request_id=? AND vendor_id=?",params[:id],current_vendor.id).first
    authorize @fav
      
      if @fav.destroy
        respond_to do |format|
              format.html {                  
                  flash[:success] = "Request has been removed from your favourite."
                  redirect_to :back
              }
              format.js{@result,@id=@fav.id}
        end
      else
        respond_to do |format|
          format.html {
              flash[:success] = "Error prevent the request to be removed from favourite."
              redirect_to :back
          }
          format.js{}
        end   
      end
          
  end
  
  
  private 
    
  def favourite_params
    params.permit(:request_id)    
  end
  
  def pundit_user  
    current_vendor 
  end
  
end
