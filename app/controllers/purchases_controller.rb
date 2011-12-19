class PurchasesController < ApplicationController

  set_tab :purchases

  before_filter :load_purchase_from_session, :only => [:new, :create, :update]

  def index
    @purchases = Purchase.all

    respond_to do |format|
      format.html
      format.csv { render :layout => false }
    end
  end

  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @purchase }
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])
  end

  def create
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to(@purchase, :notice => 'Purchase was successfully created.') }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        session.delete :purchase
        format.html { redirect_to(@purchase, :notice => 'Purchase was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to(purchases_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_purchase_from_session
    if session[:purchase]
      @purchase = Purchase.find_or_create_by_id(session[:purchase])
    else
      @purchase = Purchase.create :save_as_draft => true
      session[:purchase] = @purchase.id
    end
  end
end
