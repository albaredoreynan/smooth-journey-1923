class AmountMultipliersController < ApplicationController
  load_and_authorize_resource

  set_tab :amount_multipliers

  # GET /employees
  # GET /employees.xml
  def index
    @amount_multipliers = AmountMultiplier.accessible_by(current_ability).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @amount_multipliers }
    end
  end

  def show
    @amount_multiplier = AmountMultiplier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @amount_multiplier }
    end
  end

  def new
    @amount_multiplier = AmountMultiplier.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @amount_multiplier }
    end
  end

  # GET /employees/1/edit
  def edit
    @amount_multiplier = AmountMultiplier.find(params[:id])
  end

  # POST /employees
  # POST /employees.xml
  def create
    @amount_multiplier = AmountMultiplier.new(params[:amount_multiplier])

    respond_to do |format|
      if @amount_multiplier.save
        format.html { redirect_to(@amount_multiplier, :notice => 'Amount Multiplier was successfully created.') }
        format.xml  { render :xml => @amount_multiplier, :status => :created, :location => @amount_multiplier }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @amount_multiplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.xml
  def update
    @amount_multiplier = AmountMultiplier.find(params[:id])

    respond_to do |format|
      if @amount_multiplier.update_attributes(params[:amount_multiplier])
        format.html { redirect_to(@amount_multiplier, :notice => 'Amount Multiplier was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @amount_multiplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.xml
  def destroy
    @amount_multiplier = AmountMultiplier.find(params[:id])
    @amount_multiplier.destroy

    respond_to do |format|
      format.html { redirect_to(amount_multipliers_url) }
      format.xml  { head :ok }
    end
  end

end
