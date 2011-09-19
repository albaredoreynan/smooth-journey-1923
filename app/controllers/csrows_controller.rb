class CsrowsController < ApplicationController
  # GET /csrows
  # GET /csrows.xml
  def index
    @csrows = Csrow.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @csrows }
    end
  end

  # GET /csrows/1
  # GET /csrows/1.xml
  def show
    @csrow = Csrow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @csrow }
    end
  end

  # GET /csrows/new
  # GET /csrows/new.xml
  def new
    @csrow = Csrow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @csrow }
    end
  end

  # GET /csrows/1/edit
  def edit
    @csrow = Csrow.find(params[:id])
  end

  # POST /csrows
  # POST /csrows.xml
  def create
    @csrow = Csrow.new(params[:csrow])

    respond_to do |format|
      if @csrow.save
        format.html { redirect_to(@csrow, :notice => 'Csrow was successfully created.') }
        format.xml  { render :xml => @csrow, :status => :created, :location => @csrow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @csrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /csrows/1
  # PUT /csrows/1.xml
  def update
    @csrow = Csrow.find(params[:id])

    respond_to do |format|
      if @csrow.update_attributes(params[:csrow])
        format.html { redirect_to(@csrow, :notice => 'Csrow was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @csrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /csrows/1
  # DELETE /csrows/1.xml
  def destroy
    @csrow = Csrow.find(params[:id])
    @csrow.destroy

    respond_to do |format|
      format.html { redirect_to(csrows_url) }
      format.xml  { head :ok }
    end
  end
end
