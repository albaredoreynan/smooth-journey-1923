class ReporttemplatesController < ApplicationController
  # GET /reporttemplates
  # GET /reporttemplates.xml
  def index
    @reporttemplates = Reporttemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reporttemplates }
    end
  end

  # GET /reporttemplates/1
  # GET /reporttemplates/1.xml
  def show
    @reporttemplate = Reporttemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reporttemplate }
    end
  end

  # GET /reporttemplates/new
  # GET /reporttemplates/new.xml
  def new
    @reporttemplate = Reporttemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reporttemplate }
    end
  end

  # GET /reporttemplates/1/edit
  def edit
    @reporttemplate = Reporttemplate.find(params[:id])
  end

  # POST /reporttemplates
  # POST /reporttemplates.xml
  def create
    @reporttemplate = Reporttemplate.new(params[:reporttemplate])

    respond_to do |format|
      if @reporttemplate.save
        format.html { redirect_to(@reporttemplate, :notice => 'Reporttemplate was successfully created.') }
        format.xml  { render :xml => @reporttemplate, :status => :created, :location => @reporttemplate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reporttemplate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reporttemplates/1
  # PUT /reporttemplates/1.xml
  def update
    @reporttemplate = Reporttemplate.find(params[:id])

    respond_to do |format|
      if @reporttemplate.update_attributes(params[:reporttemplate])
        format.html { redirect_to(@reporttemplate, :notice => 'Reporttemplate was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reporttemplate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reporttemplates/1
  # DELETE /reporttemplates/1.xml
  def destroy
    @reporttemplate = Reporttemplate.find(params[:id])
    @reporttemplate.destroy

    respond_to do |format|
      format.html { redirect_to(reporttemplates_url) }
      format.xml  { head :ok }
    end
  end
end
