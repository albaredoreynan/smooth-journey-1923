class PurchaseItemsController < ApplicationController
  # GET /purchase_items
  # GET /purchase_items.xml
  def index
    if params[:commit]=="Search"
      startdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
      enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']

      @duration = startdate + ' to ' + enddate
      @purchase_items = PurchaseItem.search_by_date(startdate, enddate)
      #@categories = Category.all
    elsif params[:commit]=="Save"
      PurchaseItem.update_all(["save_as_draft=?", 0], :id => params[:purchaseitem_ids])
      redirect_to purchase_items_path
      else
        @duration = 'all'
        @purchase_items = PurchaseItem.search(params[:from],params[:to])
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @purchase_items }
        end # end respond_to
        #@categories = Category.all

      end # end if else

    #@purchase_items = PurchaseItem.search(params[:from],params[:to])

	  #respond_to do |format|
     # format.html # index.html.erb
      #format.xml  { render :xml => @purchase_items }
    #end
  end

  # GET /purchase_items/1
  # GET /purchase_items/1.xml
  def show
    @purchase_item = PurchaseItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase_item }
    end
  end

  # GET /purchase_items/new
  # GET /purchase_items/new.xml
  def new
    @purchase_item = PurchaseItem.new
    @purchase_items = PurchaseItem.all # for preview

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase_item }
    end

  end

  # GET /purchase_items/1/edit
  def edit
    @purchase_item = PurchaseItem.find(params[:id])
    @purchase_items = PurchaseItem.all # for preview
    @invoiceNumber = params[:invoiceNumber]

    #for preview
    respond_to do |format|
      format.html # edit.html.erbv
      format.xml  { render :xml => @purchase_items }
    end
    #
  end

  # POST /purchase_items
  # POST /purchase_items.xml
  def create
    @purchase_item = PurchaseItem.new(params[:purchaseitem])

    if params[:commit]=="Save"
        @purchase_item.save_as_draft = 0
    elsif params[:commit]=="Save as draft"
        @purchase_item.save_as_draft = 1
    end

    respond_to do |format|
      if @purchase_item.save
        format.html { redirect_to(@purchase_item, :notice => 'Purchase item/s successfully created.') }
        format.xml  { render :xml => @purchase_item, :status => :created, :location => @purchaseitem }
      else
        #category_count = Category.all.count
        #@category_names = Category.all.map(&:category_name).reverse
        #@category_ids = Category.all.map(&:id).reverse
        #@categorysale.category_sales.build

        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase_item.errors, :status => :unprocessable_entity }
      end
    end


    #respond_to do |format|
      #if @purchase_item.save
        #format.html { redirect_to(@purchase_item, :notice => 'Purchaseitem was successfully created.') }
        #format.xml  { render :xml => @purchase_item, :status => :created, :location => @purchaseitem }
      #else
        #format.html { render :action => "new" }
        #format.xml  { render :xml => @purchase_item.errors, :status => :unprocessable_entity }
      #end
    #end

  end

  # PUT /purchase_items/1
  # PUT /purchase_items/1.xml
  def update
    @purchase_item = PurchaseItem.find(params[:id])

    if params[:commit]=="Save"
        @purchase_item.save_as_draft = 0
    elsif params[:commit]=="Save as draft"
        @purchase_item.save_as_draft = 1
    end

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

  # DELETE /purchase_items/1
  # DELETE /purchase_items/1.xml
  def destroy
    @purchase_item = PurchaseItem.find(params[:id])
    @purchase_item.destroy

    respond_to do |format|
      format.html { redirect_to(purchase_items_url) }
      format.xml  { head :ok }
    end
  end

  def update_subcategories
    category = Category.find(params[:category_id])
    subcategories = category.subcategories

    render :update do |format|
      format.replace_html 'subcategories', :partial => 'subcategories', :object => subcategories
    end
  end

  def savemultiple
    PurchaseItem.update_all(["save_as_draft=?", 0], :id => params[:purchaseitem_ids])
    #@purchase_items = PurchaseItems.find(params[:purchaseitem_ids])
    #@purchase_items.each do |puchaseitem|
    #purchase_item.update_attributes!(params[:purchaseitem].reject { |k,v| v.blank? })
    #end
    #flash[:notice] = "Purchase item/s saved!"
  redirect_to purchase_items_path
  end

end
