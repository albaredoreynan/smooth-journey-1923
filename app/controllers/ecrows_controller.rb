class EcrowsController < ApplicationController
  # GET /ecrows
  # GET /ecrows.xml
  def index
    @ecrows = Ecrow.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ecrows }
    end
  end

  # GET /ecrows/1
  # GET /ecrows/1.xml
  def show
    @ecrow = Ecrow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ecrow }
    end
  end

  # GET /ecrows/new
  # GET /ecrows/new.xml
  def new
    @ecrow = Ecrow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ecrow }
    end
  end

  # GET /ecrows/1/edit
  def edit
    @ecrow = Ecrow.find(params[:id])
  end

  # POST /ecrows
  # POST /ecrows.xml
  def create
    @ecrow = Ecrow.new(params[:ecrow])

    respond_to do |format|
      if @ecrow.save
        format.html { redirect_to(@ecrow, :notice => 'Ecrow was successfully created.') }
        format.xml  { render :xml => @ecrow, :status => :created, :location => @ecrow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ecrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ecrows/1
  # PUT /ecrows/1.xml
  def update
    @ecrow = Ecrow.find(params[:id])

    respond_to do |format|
      if @ecrow.update_attributes(params[:ecrow])
        format.html { redirect_to(@ecrow, :notice => 'Ecrow was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ecrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ecrows/1
  # DELETE /ecrows/1.xml
  def destroy
    @ecrow = Ecrow.find(params[:id])
    @ecrow.destroy

    respond_to do |format|
      format.html { redirect_to(ecrows_url) }
      format.xml  { head :ok }
    end
  end
end
