class RestaurantsController < ApplicationController
  load_and_authorize_resource

  set_tab :restaurant

  def index
    @restaurants = Restaurant.joins(:company).accessible_by(current_ability).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurants }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  def new
    @restaurant = Restaurant.new
    current_ability.attributes_for(:new, Restaurant).each do |key, value|
      @restaurant.send("#{key}=", value)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    current_ability.attributes_for(:create, Restaurant).each do |key, value|
      @restaurant.send("#{key}=", value)
    end

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to(restaurants_path, :notice => 'Restaurant was successfully created.') }
        format.xml  { render :xml => @restaurant, :status => :created, :location => @restaurant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(current_ability.attributes_for(:update, Restaurant).merge(params[:restaurant]))
        format.html { redirect_to(@restaurant, :notice => 'Restaurant was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to(restaurants_url) }
      format.xml  { head :ok }
    end
  end
end
