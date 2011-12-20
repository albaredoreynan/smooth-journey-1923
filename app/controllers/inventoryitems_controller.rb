class InventoryitemsController < ApplicationController

  set_tab :inventory

  # GET /inventoryitems
  # GET /inventoryitems.xml
  def index

    if params[:search]
      @items = Item.search(params[:search])
    else
      @items = Item.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /inventoryitems/1
  # GET /inventoryitems/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /inventoryitems/new
  # GET /inventoryitems/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /inventoryitems/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /inventoryitems
  # POST /inventoryitems.xml
  def create
    @item = Item.new(params[:item])

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

  # PUT /inventoryitems/1
  # PUT /inventoryitems/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(inventoryitems_path, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventoryitems/1
  # DELETE /inventoryitems/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(inventoryitems_url) }
      format.xml  { head :ok }
    end
  end
end
