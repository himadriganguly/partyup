class Dashboard::HighlightsController < ApplicationController

  before_filter :authenticate_vendor!
  
  after_action :verify_authorized, only: [:edit, :update, :delete, :destroy]
  
  def index
    @highlight = current_vendor.highlights.page(params[:page]).per(10)
  end
  
  def new
    @highlight = Highlight.new
  end
  
  def create
    @highlight = Highlight.new(highlight_params)
    @highlight.vendor_id = current_vendor.id
    if @highlight.save
      flash[:notice] = "Highlight has been created successfully."
      redirect_to(:action => 'index')
    else
      render('new')
    end    
  end
  
  def edit
    @highlight = Highlight.find(params[:id])
    authorize @highlight
  end
  
  def update
    @highlight = Highlight.find(params[:id])
    authorize @highlight
    
    if @highlight.update_attributes(highlight_params)
      flash[:notice] = "Highlight updated successfully."
      redirect_to(:action => 'index')
    else      
      render('edit')
    end
  end
  
  def delete
    @highlight = Highlight.find(params[:id])
    authorize @highlight
  end
  
  def destroy
    @highlight = Highlight.find(params[:id])
    authorize @highlight
    
    @highlight.destroy
    flash[:notice] = "Highlight destroyed successfully."
    redirect_to(:action => 'index')
  end
  
  
  private
  
  def highlight_params
    params.require(:highlight).permit(:title, :description)    
  end
  
  def pundit_user  
    current_vendor 
  end
  
end
