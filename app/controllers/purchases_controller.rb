class PurchasesController < ApplicationController
  # GET /purchases
  # GET /purchases.xml
  def index
    #@purchases = Purchase.all

    #respond_to do |format|
     # format.html # index.html.erb
      #format.xml  { render :xml => @purchases }
    #end
    
    if params[:commit]=="Search"
        startdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
        enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']
        
        @duration = startdate + ' to ' + enddate
        @purchases = Purchase.search_by_date(startdate, enddate) 
        #@categories = Category.all
    elsif params[:commit]=="Submit records"
      Purchase.update_all(["save_as_draft=?", 0], :id => params[:purchase_ids])
      redirect_to purchases_path
    elsif params[:commit]=="Delete records "
      i = 0
      arr_item = Array.new
      @purchases = Purchase.find(params[:purchase_ids])
      @purchases.each do |purchase|
      purchase.destroy
         i += 1
         end  
 
      redirect_to(purchases_path)    
      flash[:notice] = 'Record/s destroyed.'
    else
      @purchases = Purchase.all
        
      end # end if else
  end

  # GET /purchases/1
  # GET /purchases/1.xml
  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  # GET /purchases/new
  # GET /purchases/new.xml
  def new
    @purchase = Purchase.new

    1.times { @purchase.purchaserows.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  # GET /purchases/1/edit
  def edit
    @purchase = Purchase.find(params[:id])
  end

  # POST /purchases
  # POST /purchases.xml
  def create
    @purchase = Purchase.new(params[:purchase])
    
    if params[:commit]=="Save"       
        @purchase.save_as_draft = 0
    elsif params[:commit]=="Save as draft"
        @purchase.save_as_draft = 1
    end

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to(@purchase, :notice => 'Purchase was successfully created.') }
        format.xml  { render :xml => @purchase, :status => :created, :location => @purchase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /purchases/1
  # PUT /purchases/1.xml
  def update
    @purchase = Purchase.find(params[:id])
    
    if params[:commit]=="Save"       
        @purchase.save_as_draft = 0
    elsif params[:commit]=="Save as draft"
        @purchase.save_as_draft = 1
    end

    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        format.html { redirect_to(@purchase, :notice => 'Purchase was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.xml
  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to(purchases_url) }
      format.xml  { head :ok }
    end
  end
  
  def savemultiple #for bulk saving
    Purchase.update_all(["save_as_draft=?", 0], :id => params[:purchase_ids])
    #@purchases = Purchases.find(params[:purchase_ids])
    #@purchases.each do |puchase|
    #purchase.update_attributes!(params[:purchase].reject { |k,v| v.blank? })
    #end
    #flash[:notice] = "Purchase/s saved!"'
    redirect_to purchases_path
  end
end
