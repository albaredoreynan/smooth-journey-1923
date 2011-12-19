class PurchasesController < ApplicationController

  set_tab :purchases

  before_filter :load_purchase_from_session, :only => [:new, :create, :update]

  def index
    if params[:commit] == "Search"

      unless params[:start_date].blank? && params[:end_date].blank?
        @purchases = Purchase.search_by_date(params[:start_date], params[:end_date])
      else
        @purchases = Purchase.all.group_by{ |purchase| purchase.date.to_date }
      end
      #@purchases = Purchase.search_by_date params['start_date'], params['end_date']

    elsif params[:commit] == "Submit records"
      Purchase.update_all(["save_as_draft=?", 0], :id => params[:purchase_ids])
      redirect_to purchases_path
    elsif params[:commit] == "Delete records "
      i = 0
      arr_item = Array.new
      @purchases = Purchase.find(params[:purchase_ids])
      @purchases.each do |purchase|
        purchase.destroy
        i += 1
      end

      redirect_to(purchases_path)
      flash[:notice] = 'Record/s destroyed.'
    else
      @purchases = Purchase.all
    end # end if else

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
