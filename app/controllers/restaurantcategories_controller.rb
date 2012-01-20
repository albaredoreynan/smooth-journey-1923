class RestaurantcategoriesController < ApplicationController
  def index
    @restaurantcategories = Restaurantcategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurantcategories }
    end
  end

  def show
    @restaurantcategory = Restaurantcategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @restaurantcategory }
    end
  end

  def new
    @restaurantcategory = Restaurantcategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurantcategory }
    end
  end

  def edit
    @restaurantcategory = Restaurantcategory.find(params[:id])
  end

  def create
    @restaurantcategory = Restaurantcategory.new(params[:restaurantcategory])

    respond_to do |format|
      if @restaurantcategory.save
        format.html { redirect_to(@restaurantcategory, :notice => 'Restaurantcategory was successfully created.') }
        format.xml  { render :xml => @restaurantcategory, :status => :created, :location => @restaurantcategory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurantcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @restaurantcategory = Restaurantcategory.find(params[:id])

    respond_to do |format|
      if @restaurantcategory.update_attributes(params[:restaurantcategory])
        format.html { redirect_to(@restaurantcategory, :notice => 'Restaurantcategory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurantcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurantcategory = Restaurantcategory.find(params[:id])
    @restaurantcategory.destroy

    respond_to do |format|
      format.html { redirect_to(restaurantcategories_url) }
      format.xml  { head :ok }
    end
  end
end
