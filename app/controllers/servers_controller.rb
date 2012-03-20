class ServersController < ApplicationController

  set_tab :sales
  set_tab :servers

  def index
    @servers = Server.accessible_by(current_ability)
  end

  def show
    @server = Server.find(params[:id])
  end

  def new
    @server = Server.new
  end

  def edit
    @server = Server.find(params[:id])
  end

  def create
    @server = Server.new(params[:server])

    if @server.save
      redirect_to servers_path, notice: 'Sale server was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @server = Server.find(params[:id])

    if @server.update_attributes(params[:server])
      redirect_to @server, notice: 'Sale server was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    redirect_to servers_url
  end
end
