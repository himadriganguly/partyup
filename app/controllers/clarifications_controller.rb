class ClarificationsController < ApplicationController
  
  before_action :login_user?
  
  after_action :verify_authorized, only: [:new, :edit, :update, :delete, :destroy]
  
  def new
    
    if Request.exists?(params[:id])
      
      @clarification = Clarification.new
      @clarification.request_id = params[:id]
      
      authorize @clarification
      
      @request = Request.find(params[:id])
      
    else
      
      flash[:error] = "Sorry the request doesn't exits where you want to submit clarification."
      redirect_to :back
      
    end
    
  end

  def create
    
    @clarification = Clarification.new(clarification_params)   
        
    if Request.exists?(params[:request_id])
      
      @clarification.request_id = params[:request_id]
      authorize @clarification
      
      if current_vendor
        @clarification.clarify = current_vendor
      elsif current_organiser
        @clarification.clarify = current_organiser
      end
      
      if @clarification.save
                
        clarifierName = full_name_object(@clarification.clarify)
        clarifierClass = @clarification.clarify.class
        request = @clarification.request
        clarifications = Clarification.where("request_id=?",params[:request_id])
        clarificationNumber = clarifications.count
        emails=[]
        
        if organiser_signed_in?
          clarifications.each do |cl|          
            emails << {"email"=>cl.clarify.email,"name"=>full_name_object(cl.clarify),"type"=>"to"} if (cl.clarify.id!=@clarification.clarify_id) && (cl.clarify.class!=@clarification.clarify_type)
          end          
        elsif vendor_signed_in?
          unless emails.include?({"email"=>@clarification.request.organiser.email,"name"=>full_name_object(@clarification.request.organiser),"type"=>"to"})  
            emails << {"email"=>@clarification.request.organiser.email,"name"=>full_name_object(@clarification.request.organiser),"type"=>"to"}
          end
        end          
            
        ClarificationMailer.new_clarification(clarifierName, clarifierClass, clarificationNumber, request, emails).deliver
         
        flash[:success] = "Clarification has been posted successfully."
        redirect_to "/requests/#{params[:request_id]}"
      else
        render('new')
      end   
      
    else
      flash[:error] = "Sorry the request doesn't exits where you want to submit the clarification."
      redirect_to(:controller=>"dashboard/requests",:action => 'index')
    end 
    
  end

  # def edit
#     
    # #if Clarification.exists?(params[:id])
      # @clarification = Clarification.find(params[:id])
      # authorize @clarification
#       
      # @request = @clarification.request
    # #else
      # #flash[:error] = "Sorry the clarification doesn't exits."
      # #redirect_to requests_path
    # #end
#     
  # end
  
  # def update
#     
    # if Clarification.exists?(params[:id])
#       
      # @clarification = Clarification.find(params[:id])
      # authorize @clarification
#       
      # if @clarification.update_attributes(clarification_params)
        # flash[:notice] = "Clarification updated successfully."
        # redirect_to request_path(:id=>@clarification.request_id)
      # else      
        # render('edit')
      # end
    # else
      # flash[:error] = "Sorry the clarification doesn't exits which you want to update."
      # redirect_to requests_path
    # end
#     
  # end
  
  
  private
  
  def login_user?
    if organiser_signed_in? || vendor_signed_in?
      return true
    else
      redirect_to :controller=>"dashboard/base", :action=>"index"
    end  
  end
  
  def clarification_params
    params.require(:clarification).permit(:request_id, :description)    
  end
  
  def pundit_user  
    if vendor_signed_in?
      current_vendor
    elsif organiser_signed_in?
      current_organiser
    end 
  end
  
end
