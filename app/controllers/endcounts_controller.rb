class EndcountsController < ApplicationController

  #set_tab :inventory

  before_filter :prepare_branch, :only => :index

  def index
    set_tab :inventory
    
    authorize! :index, Endcount
    ending_date = params[:date] ? Date.parse(params[:date]) : Date.today
    endcount_item = EndcountItem.accessible_by(current_ability).item_group

    @items = Endcount.ending_counts_at(endcount_item, ending_date, @branch.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @endcount }
      
      format.csv do
        filename = "Inventory_Item_List"
        render_csv(filename)
      end
      
      format.pdf do
        headers['Content-Disposition'] = "attachment; filename=\"Inventory_Item_List\""
        render :layout => false
      end
    end
     
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
    errors = []

    if current_user.branch?
      branch = @current_branch
    elsif current_user.client? && Branch.exists?(params[:branch_id])
      branch = Branch.find(params[:branch_id])
    else
      branch = Branch.find(params[:branch_id])
    end
    
    params[:items] ||= {}
    params[:items].each do |key, val|
      next if val[:item_count].blank?
      item = Item.find(key)
      unless current_user.admin?
        item_count = item.counted_at(entry_date)
        item_count.settings = current_user.settings
        
        #if item_count.locked?
          #errors << item.name
          #next
        #end
        
      end
      item.update_count(val[:item_count], entry_date, branch) unless val[:item_count].blank?
    end

    error_message = "Unable to update #{errors.join(', ')}"
    if errors.any?
      redirect_to endcounts_path, :alert => error_message
    else
      redirect_to endcounts_path
    end
  end
  
  def generate_endcount_list
    set_tab :list
    #@item_count = ItemCount.select("entry_date").group("entry_date").order("entry_date DESC")
    @item_count = ItemCount.find(:all, :select => "entry_date, branch_id",  :group => "entry_date, branch_id", :order => "entry_date DESC" )
  end
   
  private
  def prepare_branch
    @branch = Branch.new
    if current_user.branch?
      @branch = @current_branch
    elsif Branch.exists?(params[:branch_id])
      @branch = Branch.find(params[:branch_id])
    end
  end
end
