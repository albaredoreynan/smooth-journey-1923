class SsrowsController < ApplicationController
  # GET /ssrows
  # GET /ssrows.xml
  def index
    @ssrows = Ssrow.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ssrows }
    end
  end

  # GET /ssrows/1
  # GET /ssrows/1.xml
  def show
    @ssrow = Ssrow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ssrow }
    end
  end

  # GET /ssrows/new
  # GET /ssrows/new.xml
  def new
    @ssrow = Ssrow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ssrow }
    end
  end

  # GET /ssrows/1/edit
  def edit
    @ssrow = Ssrow.find(params[:id])
  end

  # POST /ssrows
  # POST /ssrows.xml
  def create
    @ssrow = Ssrow.new(params[:ssrow])

    respond_to do |format|
      if @ssrow.save
        format.html { redirect_to(@ssrow, :notice => 'Ssrow was successfully created.') }
        format.xml  { render :xml => @ssrow, :status => :created, :location => @ssrow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ssrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ssrows/1
  # PUT /ssrows/1.xml
  def update
    @ssrow = Ssrow.find(params[:id])

    respond_to do |format|
      if @ssrow.update_attributes(params[:ssrow])
        format.html { redirect_to(@ssrow, :notice => 'Ssrow was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ssrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ssrows/1
  # DELETE /ssrows/1.xml
  def destroy
    @ssrow = Ssrow.find(params[:id])
    @ssrow.destroy

    respond_to do |format|
      format.html { redirect_to(ssrows_url) }
      format.xml  { head :ok }
    end
  end
end
