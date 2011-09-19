class SettlementTypesController < ApplicationController
  # GET /settlement_types
  # GET /settlement_types.xml
  def index
    @settlement_types = SettlementType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settlement_types }
    end
  end

  # GET /settlement_types/1
  # GET /settlement_types/1.xml
  def show
    @settlement_type = SettlementType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @settlement_type }
    end
  end

  # GET /settlement_types/new
  # GET /settlement_types/new.xml
  def new
    @settlement_type = SettlementType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @settlement_type }
    end
  end

  # GET /settlement_types/1/edit
  def edit
    @settlement_type = SettlementType.find(params[:id])
  end

  # POST /settlement_types
  # POST /settlement_types.xml
  def create
    @settlement_type = SettlementType.new(params[:settlement_type])

    respond_to do |format|
      if @settlement_type.save
        format.html { redirect_to(@settlement_type, :notice => 'Settlement type was successfully created.') }
        format.xml  { render :xml => @settlement_type, :status => :created, :location => @settlement_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @settlement_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settlement_types/1
  # PUT /settlement_types/1.xml
  def update
    @settlement_type = SettlementType.find(params[:id])

    respond_to do |format|
      if @settlement_type.update_attributes(params[:settlement_type])
        format.html { redirect_to(@settlement_type, :notice => 'Settlement type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @settlement_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /settlement_types/1
  # DELETE /settlement_types/1.xml
  def destroy
    @settlement_type = SettlementType.find(params[:id])
    @settlement_type.destroy

    respond_to do |format|
      format.html { redirect_to(settlement_types_url) }
      format.xml  { head :ok }
    end
  end
end
