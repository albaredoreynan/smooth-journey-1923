class PurchaseitemsController < ApplicationController
  # GET /purchaseitems
  # GET /purchaseitems.xml
  def index
    if params[:commit]=="Search"
      startdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
      enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']

      @duration = startdate + ' to ' + enddate
      @purchaseitems = Purchaseitem.search_by_date(startdate, enddate)
      #@categories = Category.all
    elsif params[:commit]=="Save"
      Purchaseitem.update_all(["save_as_draft=?", 0], :id => params[:purchaseitem_ids])
      redirect_to purchaseitems_path
      else
        @duration = 'all'
        @purchaseitems = Purchaseitem.search(params[:from],params[:to])
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @purchaseitems }
        end # end respond_to
        #@categories = Category.all

      end # end if else

    #@purchaseitems = Purchaseitem.search(params[:from],params[:to])

	  #respond_to do |format|
     # format.html # index.html.erb
      #format.xml  { render :xml => @purchaseitems }
    #end
  end

  # GET /purchaseitems/1
  # GET /purchaseitems/1.xml
  def show
    @purchaseitem = Purchaseitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchaseitem }
    end
  end

  # GET /purchaseitems/new
  # GET /purchaseitems/new.xml
  def new
    @purchaseitem = Purchaseitem.new
    @purchaseitems = Purchaseitem.all # for preview

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchaseitem }
    end

  end

  # GET /purchaseitems/1/edit
  def edit
    @purchaseitem = Purchaseitem.find(params[:id])
    @purchaseitems = Purchaseitem.all # for preview
    @invoiceNumber = params[:invoiceNumber]

    #for preview
    respond_to do |format|
      format.html # edit.html.erbv
      format.xml  { render :xml => @purchaseitems }
    end
    #
  end

  # POST /purchaseitems
  # POST /purchaseitems.xml
  def create
    @purchaseitem = Purchaseitem.new(params[:purchaseitem])

    if params[:commit]=="Save"
        @purchaseitem.save_as_draft = 0
    elsif params[:commit]=="Save as draft"
        @purchaseitem.save_as_draft = 1
    end

    respond_to do |format|
      if @purchaseitem.save
        format.html { redirect_to(@purchaseitem, :notice => 'Purchase item/s successfully created.') }
        format.xml  { render :xml => @purchaseitem, :status => :created, :location => @purchaseitem }
      else
        #category_count = Category.all.count
        #@category_names = Category.all.map(&:category_name).reverse
        #@category_ids = Category.all.map(&:id).reverse
        #@categorysale.category_sales.build

        format.html { render :action => "new" }
        format.xml  { render :xml => @purchaseitem.errors, :status => :unprocessable_entity }
      end
    end


    #respond_to do |format|
      #if @purchaseitem.save
        #format.html { redirect_to(@purchaseitem, :notice => 'Purchaseitem was successfully created.') }
        #format.xml  { render :xml => @purchaseitem, :status => :created, :location => @purchaseitem }
      #else
        #format.html { render :action => "new" }
        #format.xml  { render :xml => @purchaseitem.errors, :status => :unprocessable_entity }
      #end
    #end

  end

  # PUT /purchaseitems/1
  # PUT /purchaseitems/1.xml
  def update
    @purchaseitem = Purchaseitem.find(params[:id])

    if params[:commit]=="Save"
        @purchaseitem.save_as_draft = 0
    elsif params[:commit]=="Save as draft"
        @purchaseitem.save_as_draft = 1
    end

    respond_to do |format|
      if @purchaseitem.update_attributes(params[:purchaseitem])
        format.html { redirect_to(@purchaseitem, :notice => 'Purchaseitem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchaseitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchaseitems/1
  # DELETE /purchaseitems/1.xml
  def destroy
    @purchaseitem = Purchaseitem.find(params[:id])
    @purchaseitem.destroy

    respond_to do |format|
      format.html { redirect_to(purchaseitems_url) }
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
    Purchaseitem.update_all(["save_as_draft=?", 0], :id => params[:purchaseitem_ids])
    #@purchaseitems = Purchaseitems.find(params[:purchaseitem_ids])
    #@purchaseitems.each do |puchaseitem|
    #purchaseitem.update_attributes!(params[:purchaseitem].reject { |k,v| v.blank? })
    #end
    #flash[:notice] = "Purchase item/s saved!"
  redirect_to purchaseitems_path
  end

end
