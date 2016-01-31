class Dashboard::RequestsController < ApplicationController
  
  before_filter :authenticate_organiser!, except: [:index, :show]
  
  after_action :verify_authorized, only: [:edit, :update, :delete, :cancel]
    
  def index  
    result = search_filter(params[:category],params[:city],Request)
    @request = result[:request]
    @category = result[:category]
    @city = result[:city]
  end
  
  def new
    @request = Request.new
  end
  
  def show
    @request = Request.find(params[:id])  
      
    if @request.vendor_select?
      @winner = Proposal.where("request_id=? and is_winner=?", @request.id, true).first
    end 
    if vendor_signed_in?
      if (Proposal.exists?(request_id: @request.id, vendor_id: current_vendor.id))       
          @submit = 1
          @clarify = 1    
      else
        @submit = 0
        @clarify = 0
      end
      if Favourite.exists?(request_id: @request.id, vendor_id: current_vendor.id)
        @fav=1
      else
        @fav=0
      end
    end
  end
  
  def create
    @request = Request.new(request_params)
    @request.organiser_id = current_organiser.id
    if @request.save
      
      emails = vendor_emails(@request)
      
      RequestMailer.new_request(@request, full_name_object(@request.organiser), emails).deliver
      
      flash[:notice] = "Request has been created successfully."
      redirect_to(:controller=>"dashboard/base",:action => 'index')
    else
      render('new')
    end    
  end
  
  def edit
    @request = Request.find(params[:id])
    authorize @request
  end
  
  def update
    
    @request = Request.find(params[:id])
    authorize @request
    
    if @request.update_attributes(request_edit_params)
      
      emails = related_vendor_emails(@request)
      
      RequestMailer.edit_request(@request, full_name_object(@request.organiser), emails).deliver
      
      flash[:notice] = "Request updated successfully."
      redirect_to(:controller=>'base',:action => 'index')
    else      
      render('edit')
    end
  end
  
  def delete
    @request = Request.find(params[:id])
    authorize @request
  end
  
  # def destroy
    # request = Request.find(params[:id]).destroy
    # flash[:notice] = "Request destroyed successfully."
    # redirect_to(:controller=>'base', :action => 'index')
  # end
  
  def cancel
    
    @request = Request.find(params[:id])  
    authorize @request    
    
    if !(@request.cancel?) && @request.update_attributes(:cancel=>true)
      respond_to do |format|
        format.html {
            flash[:success] = "Request has been cancelled successfully."
            redirect_to(:controller=>'base', :action => 'index')
           }
      end       
    else  
      respond_to do |format| 
        format.html {
          flash[:error] = "Some errors prevent the project to be cancelled."
          redirect_to(:controller=>'base', :action => 'index')
        }
      end 
    end
    
  end
  
  # def accept_toggle
#     
    # @request = Request.find(params[:id])      
#     
    # if @request.accept_proposal?
#        
      # @request.update_attributes(:accept_proposal=>false)      
      # respond_to do |format|
        # format.html {
            # flash[:success] = "Request has been paused successfully. No proposals will be accepted now."
            # redirect_to :back
        # }
      # end       
    # else  
      # @request.update_attributes(:accept_proposal=>true)       
      # respond_to do |format| 
        # format.html {
          # flash[:success] = "Request has been started successfully. Vendors can post proposals now."
          # redirect_to :back
        # }
      # end 
    # end
#     
  # end
  
  def vendor_invite
    
    if Request.exists?(params[:request_id]) && Vendor.exists?(params[:vendor_id])
    
      request = Request.find(params[:request_id])
      vendor = Vendor.find(params[:vendor_id])
      
      organiserName = full_name_object(request.organiser)
      email = [{"email"=>vendor.email,"name"=>full_name_object(vendor),"type"=>"to"}]
      
      #request = {:title=>request.title,:budget=>request.budget}    
      #vendor = {:email=>vendor.email,:name=>full_name_object(vendor),:type=>"to"}
      
      if (vendor.category_id == request.category_id) && (!request.vendor_select? && !request.cancel? && request.date>Time.now.to_date)      
        
        RequestMailer.vendor_invite(request, organiserName, vendor, email).deliver
        
        flash[:success] = "Invitation has been sent to the Vendor"
        redirect_to :back
      
      elsif (vendor.category_id != request.category_id)
        
        flash[:error] = "Invitation cannot be sent to the Vendor as because category mismatch with selected Request"
        redirect_to :back
        
      else
        
        flash[:error] = "Invitation cannot be sent due to some error."
        redirect_to :back
        
      end
      
    end 
               
  end

 
  private
    
  def request_params
    params.require(:request).permit(:title,:city_id,:venue,:category_id,:hours,:budget,:guests,:date,:time,:description)    
  end
  
  def request_edit_params
    params.require(:request).permit(:title,:venue,:hours,:budget,:guests,:date,:time,:description)    
  end
  
  def pundit_user  
    current_organiser
  end
   
end
