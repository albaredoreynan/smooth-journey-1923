class EndcountsController < ApplicationController

  set_tab :inventory

  # GET /endcounts
  # GET /endcounts.xml
  def index
    if params[:commit] == "Search"
      unless params[:start_date].blank? && params[:end_date].blank?
        @endcounts = Endcount.search_by_date(params[:start_date], params[:end_date])
      else
        @endcounts = Endcount.all.group_by{ |endcount| endcount.date.to_date }
      end  
      # startdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
      # enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']
# 
      # @endcounts = Endcount.where("begin_date >= ? AND begin_date <= ?",startdate,enddate).all
    elsif params[:commit] == "Submit records "
      Endcount.update_all(["save_as_draft=?", 0], :id => params[:endcount_ids]) #passed an empty hash
      redirect_to(endcounts_path, :notice => "Record/s submitted.")
    elsif params[:commit] == "Destroy records"
      i = 0
      arr_item = Array.new
      @endcounts = Endcount.find(params[:endcount_ids])
      @endcounts.each do |endcount|
        endcount.destroy
        i += 1
      end

      redirect_to(endcounts_path)
      flash[:notice] = 'Record/s destroyed.'
    else
      @endcounts = Endcount.all
    end
  end
  # GET /endcounts/1
  # GET /endcounts/1.xml
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
end
