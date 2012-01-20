class ConversionsController < ApplicationController

  set_tab :database

  def index
    @conversions = Conversion.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conversions }
    end
  end

  def show
    @conversion = Conversion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @conversion }
    end
  end

  def new
    @conversion = Conversion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conversion }
    end
  end

  def edit
    @conversion = Conversion.find(params[:id])
  end

  def create
    @conversion = Conversion.new(params[:conversion])

    respond_to do |format|
      if @conversion.save
        format.html { redirect_to(conversions_path, :notice => 'Conversion was successfully created.') }
        format.xml  { render :xml => @conversion, :status => :created, :location => @conversion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conversion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @conversion = Conversion.find(params[:id])

    respond_to do |format|
      if @conversion.update_attributes(params[:conversion])
        format.html { redirect_to(conversions_path, :notice => 'Conversion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conversion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @conversion = Conversion.find(params[:id])
    @conversion.destroy

    respond_to do |format|
      format.html { redirect_to(conversions_url) }
      format.xml  { head :ok }
    end
  end
end
