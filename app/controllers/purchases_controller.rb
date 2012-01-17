class PurchasesController < ApplicationController

  set_tab :purchases

  before_filter :load_purchase_from_session, :only => [:new, :create]

  def index
    if params[:start_date] || params[:end_date] || params[:invoice_number] || params[:supplier]
      @purchases = Purchase.accessible_by(current_ability).non_draft.search(params).page(params[:page])
    else
      @purchases = Purchase.accessible_by(current_ability).non_draft.page(params[:page])
    end

    respond_to do |format|
      format.html
      format.csv { render :layout => false }
    end
  end

  def show
    @purchase = Purchase.find(params[:id])
    authorize! :show, @purchase

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  def new
    current_ability.attributes_for(:new, Purchase).each do |key, value|
      @purchase.send("#{key}=", value)
    end
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
      current_ability.attributes_for(:create, Purchase).each do |key, value|
        @purchase.send("#{key}=", value)
      end
      if @purchase.save
        @purchase.update_attribute(:save_as_draft, false)
        format.html { redirect_to(@purchase, :notice => 'Purchase was successfully created.') }
      end
    end
  end

  def update
    @purchase = Purchase.find(params[:id])
    authorize! :update, @purchase
    respond_to do |format|
      attr =            params[:purchase]
      attr = attr.merge({save_as_draft: false})
      attr = attr.merge({:branch => current_branch}) if current_user.branch?
      if @purchase.update_attributes(attr)
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
      purchase_attrs = { save_as_draft: true }
      if current_user.branch?
        purchase_attrs.merge!({ branch: current_branch })
      end
      @purchase = Purchase.create purchase_attrs
      session[:purchase] = @purchase.id
    end
  end
end
