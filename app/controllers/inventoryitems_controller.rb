class InventoryitemsController < ApplicationController
  load_and_authorize_resource :item

  set_tab :inventory

  def index
    if params[:search]
      @items = Item.accessible_by(current_ability).search(params[:search]).page(params[:page])
    else
      @items = Item.accessible_by(current_ability).page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  def new
    @item = Item.new
    current_ability.attributes_for(:new, Item).each do |key, value|
      @item.send("#{key}=", value)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
    authorize! :edit, @item
  end

  def create
    @item = Item.new(params[:item])
    current_ability.attributes_for(:create, Item).each do |key, value|
      @item.send("#{key}=", value)
    end
    respond_to do |format|
      if @item.save
        @item.item_count = params[:item][:item_count]
        format.html { redirect_to(inventoryitems_path, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update_attributes(current_ability.attributes_for(:update, Item).merge(params[:item]))
        format.html { redirect_to(inventoryitems_path, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(inventoryitems_url) }
      format.xml  { head :ok }
    end
  end
  
  def available_units
    @item = Item.find(params[:id])
    @available_units = @item.available_units
    render :json => @available_units
  end
end
