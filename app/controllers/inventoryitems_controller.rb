class InventoryitemsController < ApplicationController
  # GET /inventoryitems
  # GET /inventoryitems.xml
  def index
    @inventoryitems = Inventoryitem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inventoryitems }
    end
  end

  # GET /inventoryitems/1
  # GET /inventoryitems/1.xml
  def show
    @inventoryitem = Inventoryitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inventoryitem }
    end
  end

  # GET /inventoryitems/new
  # GET /inventoryitems/new.xml
  def new
    @inventoryitem = Inventoryitem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inventoryitem }
    end
  end

  # GET /inventoryitems/1/edit
  def edit
    @inventoryitem = Inventoryitem.find(params[:id])
  end

  # POST /inventoryitems
  # POST /inventoryitems.xml
  def create
    @inventoryitem = Inventoryitem.new(params[:inventoryitem])

    respond_to do |format|
      if @inventoryitem.save
        format.html { redirect_to(@inventoryitem, :notice => 'Inventoryitem was successfully created.') }
        format.xml  { render :xml => @inventoryitem, :status => :created, :location => @inventoryitem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inventoryitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventoryitems/1
  # PUT /inventoryitems/1.xml
  def update
    @inventoryitem = Inventoryitem.find(params[:id])

    respond_to do |format|
      if @inventoryitem.update_attributes(params[:inventoryitem])
        format.html { redirect_to(@inventoryitem, :notice => 'Inventoryitem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventoryitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventoryitems/1
  # DELETE /inventoryitems/1.xml
  def destroy
    @inventoryitem = Inventoryitem.find(params[:id])
    @inventoryitem.destroy

    respond_to do |format|
      format.html { redirect_to(inventoryitems_url) }
      format.xml  { head :ok }
    end
  end
end
