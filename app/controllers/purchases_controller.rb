class PurchasesController < ApplicationController

  set_tab :purchases

  def index
    authorize! :index, Purchase
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
    @purchase = Purchase.new
    current_ability.attributes_for(:new, Purchase).each do |key, value|
      @purchase.send("#{key}=", value)
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @purchase }
    end
  end

  def create
    @purchase = Purchase.new(params[:purchase])
    @purchase.created_by = current_user
    respond_to do |format|
      current_ability.attributes_for(:create, Purchase).each do |key, value|
        @purchase.send("#{key}=", value)
      end

      if @purchase.save
        @purchase.update_attribute(:save_as_draft, false)
        format.html { redirect_to(purchases_path, :notice => 'Purchase was successfully created.') }
      else
        format.html { render :new, :alert => 'Unable to save your purchase. Please try again.' }
      end
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])
    authorize! :edit, @purchase
  end

  def update
    @purchase = Purchase.find(params[:id])
    authorize! :update, @purchase
    if current_user.branch?
      @purchase.branch = current_branch
    end

    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        session.delete :purchase
        format.html { redirect_to(purchases_path, :notice => 'Purchase was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    authorize! :delete, @purchase
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to(purchases_url) }
      format.xml  { head :ok }
    end
  end
end
