class CategorysalesController < ApplicationController

  def index
      if params[:commit]=="Search"
        startdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
        enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']

        @duration = startdate + ' to ' + enddate
        @categorysales = Categorysale.search_by_date(startdate, enddate)
        @categories = Category.all
      else
        @duration = 'all'
        @categorysales = Categorysale.where("cs_date ").includes(:csrows)
        @categories = Category.all
      end

      render :template => 'shared/categorysales'
  end


  def show
    @categorysale = Categorysale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categorysale }
    end
  end


  def new
    @categorysale = Categorysale.new
    category_count = Category.all.count

    respond_to do |format|
      category_count.times do
        @category_names = Category.all.map(&:name).reverse
        @category_ids = Category.all.map(&:id).reverse
        @categorysale.csrows.build
      end
      format.html # new.html.erb
      format.xml  { render :xml => @categorysale }
    end
  end


  def edit
    @categorysale = Categorysale.find(params[:id])
    category_count = @categorysale.csrows.count

    @category_names = Category.all.map(&:name).reverse
    @category_ids = Category.all.map(&:id).reverse
    #category_count.times do
    @categorysale.csrows.build
    #end
  end


  def create
    @categorysale = Categorysale.new(params[:categorysale])
      if params[:commit]=="Save"
        @categorysale.save_as_draft = 0
      elsif params[:commit]=="Save as Draft"
        @categorysale.save_as_draft = 1
      end

    respond_to do |format|
      if @categorysale.save
        format.html { redirect_to(@categorysale, :notice => 'Category Sale was successfully created.') }
        format.xml  { render :xml => @categorysale, :status => :created, :location => @categorysale }
      else
        category_count = Category.all.count
        @category_names = Category.all.map(&:name).reverse
        @category_ids = Category.all.map(&:id).reverse
        @categorysale.csrows.build

        format.html { render :action => "new" }
        format.xml  { render :xml => @categorysale.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @categorysale = Categorysale.find(params[:id])

    respond_to do |format|
      if @categorysale.update_attributes(params[:categorysale])
        format.html { redirect_to(@categorysale, :notice => 'Categorysale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categorysale.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @categorysale = Categorysale.find(params[:id])
    @categorysale.destroy

    respond_to do |format|
      format.html { redirect_to(categorysales_url) }
      format.xml  { head :ok }
    end
  end

end
