class CategorySalesController < ApplicationController
  # GET /category_sales
  # GET /category_sales.xml
  def index
    @category_sales = category_sale.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @category_sales }
    end
  end

  # GET /category_sales/1
  # GET /category_sales/1.xml
  def show
    @category_sale = category_sale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category_sale }
    end
  end

  # GET /category_sales/new
  # GET /category_sales/new.xml
  def new
    @category_sale = category_sale.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category_sale }
    end
  end

  # GET /category_sales/1/edit
  def edit
    @category_sale = category_sale.find(params[:id])
  end

  # POST /category_sales
  # POST /category_sales.xml
  def create
    @category_sale = category_sale.new(params[:category_sale])

    respond_to do |format|
      if @category_sale.save
        format.html { redirect_to(@category_sale, :notice => 'category_sale was successfully created.') }
        format.xml  { render :xml => @category_sale, :status => :created, :location => @category_sale }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category_sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /category_sales/1
  # PUT /category_sales/1.xml
  def update
    @category_sale = category_sale.find(params[:id])

    respond_to do |format|
      if @category_sale.update_attributes(params[:category_sale])
        format.html { redirect_to(@category_sale, :notice => 'category_sale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category_sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /category_sales/1
  # DELETE /category_sales/1.xml
  def destroy
    @category_sale = category_sale.find(params[:id])
    @category_sale.destroy

    respond_to do |format|
      format.html { redirect_to(category_sales_url) }
      format.xml  { head :ok }
    end
  end
end
