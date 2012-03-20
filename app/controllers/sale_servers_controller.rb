class SaleServersController < ApplicationController
  
  set_tab :sales
  set_tab :sale_servers
  # GET /sale_servers
  # GET /sale_servers.json
  def index
    @sale_servers = SaleServer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sale_servers }
    end
  end

  # GET /sale_servers/1
  # GET /sale_servers/1.json
  def show
    @sale_server = SaleServer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale_server }
    end
  end

  # GET /sale_servers/new
  # GET /sale_servers/new.json
  def new
    @sale_server = SaleServer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale_server }
    end
  end

  # GET /sale_servers/1/edit
  def edit
    @sale_server = SaleServer.find(params[:id])
  end

  # POST /sale_servers
  # POST /sale_servers.json
  def create
    @sale_server = SaleServer.new(params[:sale_server])

    respond_to do |format|
      if @sale_server.save
        format.html { redirect_to @sale_server, notice: 'Sale server was successfully created.' }
        format.json { render json: @sale_server, status: :created, location: @sale_server }
      else
        format.html { render action: "new" }
        format.json { render json: @sale_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sale_servers/1
  # PUT /sale_servers/1.json
  def update
    @sale_server = SaleServer.find(params[:id])

    respond_to do |format|
      if @sale_server.update_attributes(params[:sale_server])
        format.html { redirect_to @sale_server, notice: 'Sale server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sale_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_servers/1
  # DELETE /sale_servers/1.json
  def destroy
    @sale_server = SaleServer.find(params[:id])
    @sale_server.destroy

    respond_to do |format|
      format.html { redirect_to sale_servers_url }
      format.json { head :no_content }
    end
  end
end
