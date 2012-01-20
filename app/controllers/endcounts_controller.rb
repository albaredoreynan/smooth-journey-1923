class EndcountsController < ApplicationController

  set_tab :inventory

  def index
    authorize! :index, Endcount
    ending_date = params[:date] ? Date.parse(params[:date]) : Date.today
    @items = Endcount.ending_counts_at(EndcountItem.accessible_by(current_ability), ending_date)
  end

  def show
    @endcount = Endcount.find(params[:id])

    respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml => @endcount }
    end
  end

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

  def destroy
    @endcount = Endcount.find(params[:id])
    @endcount.destroy

    respond_to do |format|
      format.html { redirect_to(endcounts_url) }
      format.xml  { head :ok }
    end
  end

  def update_item_counts
    entry_date = params[:entry_date].nil? ? Date.today : Date.parse(params[:entry_date])

    params[:items] ||= {}
    params[:items].each do |key, val|
      next if val[:item_count].blank?
      item = Item.find(key)
      unless current_user.admin?
        item_count = item.counted_at(entry_date)
        item_count.setting = current_user.setting
        next if item_count.locked?
      end
      item.update_count(val[:item_count], entry_date) unless val[:item_count].blank?
    end

    redirect_to endcounts_path
  end
end
