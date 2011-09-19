class SettlementSalesController < ApplicationController

  def index
    @settlement_sales = SettlementSale.all.group_by { |ss| ss.ss_date }
    @settlement_types = SettlementType.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settlement_sales }
    end
  end

  def show
    @settlement_sale = SettlementSale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @settlement_sale }
    end
  end

  def new
    @settlement_sale = SettlementSale.new
    @settlement_type = SettlementType.all
    settlement_type_count = SettlementType.all.count
    
    settlement_type_count.times do
       @settlement_type_names = SettlementType.all.map(&:st_name).reverse
       @settlement_type_ids = SettlementType.all.map(&:id).reverse
       @settlement_sale.ssrows.build 
    end
          
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @settlement_sale }
    end
  end

  def edit
    @settlement_sale = SettlementSale.find(params[:id])
    @settlement_type = SettlementType.all
    settlement_type_count = SettlementType.all.count
    
    settlement_type_count.times do
       @settlement_type_names = SettlementType.all.map(&:st_name).reverse
       @settlement_type_ids = SettlementType.all.map(&:id).reverse
       @settlement_sale.ssrows.build 
    end
  end

  def create
    @settlement_sale = SettlementSale.new(params[:settlement_sale])
      
    if params[:commit]=="Save"       
        @settlement_sale.save_as_draft = 0
    elsif params[:commit]=="Save as Draft"
        @settlement_sale.save_as_draft = 1  
    end        
    
    respond_to do |format|
      if @settlement_sale.save
        format.html { redirect_to(@settlement_sale, :notice => 'Settlement Sale was successfully created.') }
        format.xml  { render :xml => @settlement_sale, :status => :created, :location => @settlement_sale }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @settlement_sale.errors, :status => :unprocessable_entity }
      end
    end  
 end

  def update
    @settlement_sale = SettlementSale.find(params[:id])

    respond_to do |format|
      if @settlement_sale.update_attributes(params[:settlement_sale])
        format.html { redirect_to(@settlement_sale, :notice => 'Settlement sale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @settlement_sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @settlement_sale = SettlementSale.find(params[:id])
    @settlement_sale.destroy

    respond_to do |format|
      format.html { redirect_to(settlement_sales_url) }
      format.xml  { head :ok }
    end
  end

  def search
    @searchdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
    @enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']
    @header = "Search results for: " + @searchdate + ' to ' + @enddate
    @settlement_sales = SettlementSale.where("ss_date >= ? and ss_date <= ?",@searchdate,@enddate).group_by { |ss| ss.ss_date }
    render :template => 'shared/settlement_sales'
  end

  def serversales
    @settlement_sales = SettlementSale.all(:order => "ss_date ASC")
    @settlement_types = SettlementType.all
    render :template => 'shared/server_sales_by_settlement_type'
  end
  
  def serversales_search
    @settlement_types = SettlementType.all
    @searchdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
    @enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']
    @employee_firstName = params[:employee][:employee_id]
    
    @header = "Search results for: " + Employee.find(@employee_firstName).employee_firstName + ',' + @searchdate + ' to ' + @enddate
    
    employee_id = Employee.where("employee_firstName = ? AND employee_lastName = ?",@employee_firstName,@employee_lastName)
    @settlement_sales = SettlementSale.where("(ss_date >= ? AND ss_date <= ?) OR (employee_id = ?)",@searchdate,@enddate,employee_id)
    render :template => 'shared/server_sales_by_settlement_type'
  end
end
