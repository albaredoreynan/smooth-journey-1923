class EcrowController < ApplicationController
  # GET /ecrows
  # GET /ecrows.xml
  def index
    @item_counts = ItemCount.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @item_counts }
    end
  end

  # GET /ecrows/1
  # GET /ecrows/1.xml
  def show
    @item_count = ItemCount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item_count }
    end
  end

  # GET /ecrows/new
  # GET /ecrows/new.xml
  def new
    @item_count = ItemCount.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item_count }
    end
  end

  # GET /ecrows/1/edit
  def edit
    @item_count = ItemCount.find(params[:id])
  end

  # POST /ecrows
  # POST /ecrows.xml
  def create
    @item_count = ItemCount.new(params[:item_count])

    respond_to do |format|
      if @item_count.save
        format.html { redirect_to(@item_count, :notice => 'ItemCount was successfully created.') }
        format.xml  { render :xml => @item_count, :status => :created, :location => @ecrow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item_count.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ecrows/1
  # PUT /ecrows/1.xml
  def update
    @item_count = ItemCount.find(params[:id])

    respond_to do |format|
      if @item_count.update_attributes(params[:ecrow])
        format.html { redirect_to(@item_count, :notice => 'ItemCount was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item_count.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ecrows/1
  # DELETE /ecrows/1.xml
  def destroy
    @item_count = ItemCount.find(params[:id])
    @item_count.destroy

    respond_to do |format|
      format.html { redirect_to(ecrows_url) }
      format.xml  { head :ok }
    end
  end
end
