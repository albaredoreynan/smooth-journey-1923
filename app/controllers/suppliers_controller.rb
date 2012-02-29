class SuppliersController < ApplicationController

  set_tab :database

  def index
    authorize! :index, Supplier
    @suppliers = Supplier.accessible_by(current_ability).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @suppliers }
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
    authorize! :show, @supplier

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @supplier }
    end
  end

  def new
    @supplier = Supplier.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @supplier }
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
    authorize! :edit, @supplier
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    @supplier.company = @current_company
    authorize! :create, @supplier

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to('/suppliers', :notice => 'Supplier was successfully created.') }
        format.xml  { render :xml => @supplier, :status => :created, :location => @supplier }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @supplier = Supplier.find(params[:id])
    authorize! :update, @supplier

    respond_to do |format|
      if @supplier.update_attributes(params[:supplier])
        format.html { redirect_to('/suppliers', :notice => 'Supplier was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    authorize! :destroy, @supplier
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to(suppliers_url) }
      format.xml  { head :ok }
    end
  end
end
