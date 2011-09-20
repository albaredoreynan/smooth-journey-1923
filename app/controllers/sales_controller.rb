class SalesController < ApplicationController

  def index
    @sales = Sale.all.group_by{ |sale| sale.date.to_date }
    @categories = Category.all
    
    if(params[:commit]=="Search")
        from = params[:from]['(1i)']+ '-' + params[:from]['(2i)'] + '-' + params[:from]['(3i)']
        to = params[:to]['(1i)']+ '-' + params[:to]['(2i)'] + '-' + params[:to]['(3i)']
        @sales = Sale.search_date_range(from,to).group_by{ |sale| sale.date.to_date }
    end
    
  end

  def show
    @sale = Sale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sale }
    end
  end

  def new
    @sale = Sale.new
    category_count = Category.all.count
    settlement_type_count = SettlementType.all.count  
    
    respond_to do |format|
      category_count.times do
        @category_names = Category.all.map(&:category_name).reverse
        @category_ids = Category.all.map(&:id).reverse
        @sale.csrows.build  
      end
      
      settlement_type_count.times do
         @settlement_type_names = SettlementType.all.map(&:st_name).reverse
         @settlement_type_ids = SettlementType.all.map(&:id).reverse
         @sale.ssrows.build 
      end
      format.html # new.html.erb
      format.xml  { render :xml => @sale }
    end
  end

  def edit
    @sale = Sale.find(params[:id])
    
    if params[:commit]=="Save"       
       @sale.save_as_draft = 0
    elsif params[:commit]=="Save as Draft"
       @sale.save_as_draft = 1  
    end
    
    @category_names = Category.all.map(&:category_name).reverse
    @category_ids = Category.all.map(&:id).reverse
    @settlement_type_names = SettlementType.all.map(&:st_name).reverse
    @settlement_type_ids = SettlementType.all.map(&:id).reverse
  end

  def create
    @sale = Sale.new(params[:sale])
    if params[:commit]=="Save"       
       @sale.save_as_draft = 0
    elsif params[:commit]=="Save as Draft"
       @sale.save_as_draft = 1  
    end  

    respond_to do |format|
      if @sale.save
        format.html { redirect_to(@sale, :notice => 'Sale was successfully created.') }
        format.xml  { render :xml => @sale, :status => :created, :location => @sale }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @sale = Sale.find(params[:id])
    
    if params[:commit]=="Save"       
       @sale.save_as_draft = 0
    elsif params[:commit]=="Save as Draft"
       @sale.save_as_draft = 1  
    end

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to(@sale, :notice => 'Sale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to(sales_url) }
      format.xml  { head :ok }
    end
  end
  
  def sales_by_settlement_type
      @sales = Sale.all.group_by{ |sale| sale.date.to_date }
      @settlement_types = SettlementType.all
      
      if(params[:commit]=="Search")
        
        from = params[:from]['(1i)']+ '-' + params[:from]['(2i)'] + '-' + params[:from]['(3i)']
        to = params[:to]['(1i)']+ '-' + params[:to]['(2i)'] + '-' + params[:to]['(3i)']
        @sales = Sale.search_date_range(from,to).group_by{ |sale| sale.date.to_date }
      end
  end
  
  def sales_by_server
      @sales = Sale.all
      @settlement_types = SettlementType.all
      
      if(params[:commit]=="Search")
        from = params[:from]['(1i)']+ '-' + params[:from]['(2i)'] + '-' + params[:from]['(3i)']
        to = params[:to]['(1i)']+ '-' + params[:to]['(2i)'] + '-' + params[:to]['(3i)']
        @sales = Sale.search_date_range(from,to).search_by_employee(params[:employee][:employee_id])
      end
  end
end
