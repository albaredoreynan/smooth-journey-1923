class PurchaseItemsController < ApplicationController

  respond_to :html, :json

  before_filter :load_purchase, :except => :validate

  def new
    @purchase_item = @purchase.purchase_items.new
    respond_with @purchase_item do |format|
      format.js { render :partial => 'purchase_items/form', :locals => { :purchase_item => @purchase_item }, :layout => false }
    end
  end

  def create
    @purchase_item = @purchase.purchase_items.new(params[:purchase_item])

    if @purchase_item.save
      render :partial => 'purchases/form', :locals => { :purchase => @purchase }, :layout => false, :status => :created
    else
      render :json => @purchase_item.errors, :status => :unprocessable_entity
    end
  end

  def update
    @purchase_item = PurchaseItem.find(params[:id])

    respond_to do |format|
      if @purchase_item.update_attributes(params[:purchaseitem])
        format.html { redirect_to(@purchase_item, :notice => 'Purchaseitem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase_item = PurchaseItem.find(params[:id])
    @purchase_item.destroy

    respond_to do |format|
      format.html { head :ok }
      format.xml  { head :ok }
      format.js
    end
  end

  def validate
    purchase_item = PurchaseItem.new(params[:purchase_item])
    if purchase_item.valid?
      render :partial => '/purchases/purchase_item_row', :locals => { :purchase_item => purchase_item }, :status => :accepted
    else
      render :json => purchase_item.errors, :status => :unprocessable_entity
    end
  end

  private
  def load_purchase
    @purchase = Purchase.find(params[:purchase_id])
  end
end
