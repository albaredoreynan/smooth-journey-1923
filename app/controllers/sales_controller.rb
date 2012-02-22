class SalesController < ApplicationController

  set_tab :sales

  def index
    @sales = Sale.accessible_by(current_ability)
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
    categories = Category.accessible_by(current_ability)
    categories.each do |c|
      @sale.category_sales.build({:category_id => c.id})
    end

    settlement_types = SettlementType.accessible_by(current_ability)
    settlement_types.each do |st|
      @sale.settlement_type_sales.build({:settlement_type_id => st.id})
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale }
    end
  end

  def edit
    @sale = Sale.find(params[:id])

    if params[:commit] == "Save"
      @sale.save_as_draft = 0
    elsif params[:commit] == "Save as Draft"
      @sale.save_as_draft = 1
    end

    @category_names = Category.all.map(&:name).reverse
    @category_ids = Category.all.map(&:id).reverse
    @settlement_type_names = SettlementType.all.map(&:name).reverse
    @settlement_type_ids = SettlementType.all.map(&:id).reverse
  end

  def create
    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if current_user.branch?
        @sale.branch = @current_branch
      end
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

    if params[:commit] == "Save"
      @sale.save_as_draft = 0
    elsif params[:commit] == "Save as Draft"
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

    if params[:commit]=="Search"
      from = params[:from]['(1i)']+ '-' + params[:from]['(2i)'] + '-' + params[:from]['(3i)']
      to = params[:to]['(1i)']+ '-' + params[:to]['(2i)'] + '-' + params[:to]['(3i)']
      @sales = Sale.search_date_range(from,to).group_by{ |sale| sale.date.to_date }
    end
  end

  def sales_by_server
    @sales = Sale.all
    @settlement_types = SettlementType.all

    if params[:commit] == "Search"
      from = params[:from]['(1i)']+ '-' + params[:from]['(2i)'] + '-' + params[:from]['(3i)']
      to = params[:to]['(1i)']+ '-' + params[:to]['(2i)'] + '-' + params[:to]['(3i)']
      @sales = Sale.search_by_employee_or_date(from,to,params[:employee][:employee_id])
    elsif params[:commit] == "Submit records"
      Sale.update_all(["save_as_draft=?", 0], :id => params[:sale_ids])
      redirect_to sales_by_server_path
    end
  end
end
