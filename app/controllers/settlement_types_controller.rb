class SettlementTypesController < ApplicationController
  load_and_authorize_resource

  set_tab :database

  def index
    @settlement_types = SettlementType.accessible_by(current_ability).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settlement_types }
    end
  end

  def show
    @settlement_type = SettlementType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @settlement_type }
    end
  end

  def new
    @settlement_type = SettlementType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @settlement_type }
    end
  end

  def edit
    @settlement_type = SettlementType.find(params[:id])
  end

  def create
    @settlement_type = SettlementType.new(params[:settlement_type])

    respond_to do |format|
      if @settlement_type.save
        format.html { redirect_to(settlement_types_path, :notice => 'Settlement type was successfully created.') }
        format.xml  { render :xml => @settlement_type, :status => :created, :location => @settlement_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @settlement_type.errors, :status => :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @settlement_type = SettlementType.find(params[:id])
    @settlement_type.destroy

    respond_to do |format|
      format.html { redirect_to(settlement_types_url) }
      format.xml  { head :ok }
    end
  end
end
