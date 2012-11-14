class LaborHoursController < ApplicationController
  set_tab :labor_hours

  def index
    @labor_hours = LaborHour.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @labor_hours }
      format.csv
    end
  end

  def show
    @labor_hour = LaborHour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @labor_hour }
    end
  end

  def new
    @labor_hour = LaborHour.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @labor_hour }
    end
  end

  def edit
    @labor_hour = LaborHour.find(params[:id])
  end

  def create
    @labor_hour = LaborHour.new(params[:labor_hour])

    respond_to do |format|
      if @labor_hour.save
        format.html { redirect_to(labor_hours_path, :notice => 'Working Hours successfully inputed') }
        format.xml  { render :xml => @labor_hour, :status => :created, :location => @labor_hour }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @labor_hour.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @labor_hour = LaborHour.find(params[:id])

    respond_to do |format|
      if @labor_hour.update_attributes(params[:labor_hour])
        format.html { redirect_to(@labor_hour, :notice => 'Working Hours was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @labor_hour.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @labor_hour = LaborHour.find(params[:id])
    @labor_hour.destroy

    respond_to do |format|
      format.html { redirect_to(labor_hours_url, :notice => 'Working Hours has been deleted.') }
      format.xml  { head :ok }
    end
  end

  def all_employees_list
    
    @all_employees = Employee.find(:all)
  end
end
