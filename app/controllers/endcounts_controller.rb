class EndcountsController < ApplicationController

  set_tab :inventory

  def index
    #@beginning_date = params[:beginning_date].blank? ?  Time.now.beginning_of_month : Date.parse(params[:beginning_date])
    #@ending_date = params[:ending_date].blank? ? Time.now : Date.parse(params[:ending_date])
    @items = Item.all
  end

  def show
    @endcount = Endcount.find(params[:id])

    respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml => @endcount }
    end
  end

  # GET /endcounts/new
  # GET /endcounts/new.xml
  def new
    @endcount = Endcount.new

    count = Item.all.count

    @monthbeginning = Date.today.at_beginning_of_month

    @items = Item.all
    @items.each do |i|
      @endcount.item_counts.build ({item_id: i.id, begin_count: i.end_count})
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @endcount }
    end
  end

  # GET /endcounts/1/edit
  def edit
    @endcount = Endcount.find(params[:id])

    #@endcounts = Endcount.all # for preview/save the draft
    count = Item.all.count

    @monthbeginning = Date.today.at_beginning_of_month

    @item_ids = Item.all.map(&:id).reverse
    @inventoryitems = Item.all.map(&:name).reverse
    @begin_counts = Item.all.map(&:begin_count).reverse

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @endcount }
    end
  end

  # POST /endcounts
  # POST /endcounts.xml
  def create
    @endcount = Endcount.new(params[:endcount])

    if params[:commit] == "Save"
      @endcount.save_as_draft = 0
    elsif params[:commit] == "Save as draft"
      @endcount.save_as_draft = 1
    end

    respond_to do |format|
      if @endcount.save
        format.html { redirect_to(@endcount, :notice => 'Endcount was successfully created.') }
        format.xml  { render :xml => @endcount, :status => :created, :location => @endcount }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @endcount.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /endcounts/1
  # PUT /endcounts/1.xml
  def update
    @endcount = Endcount.find(params[:id])

    if params[:commit] == "Save"
        @endcount.save_as_draft = 0
    elsif params[:commit] == "Save as draft"
        @endcount.save_as_draft = 1
    end

    respond_to do |format|
      if @endcount.update_attributes(params[:endcount])
        format.html { redirect_to(@endcount, :notice => 'Endcount was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @endcount.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /endcounts/1
  # DELETE /endcounts/1.xml
  def destroy
    @endcount = Endcount.find(params[:id])
    @endcount.destroy

    respond_to do |format|
      format.html { redirect_to(endcounts_url) }
      format.xml  { head :ok }
    end
  end

  def savechecked
    Endcount.update_all(["save_as_draft=?", 0], :id => params[:endcount_ids])
    redirect_to endcounts_path
  end

  def update_item_counts
    params[:items].each do |key, val|
      item = Item.find(key)
      item.item_count = val[:item_count] unless val[:item_count].blank?
    end
    redirect_to endcounts_path
  end
end
