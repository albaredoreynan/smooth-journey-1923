class BranchesController < ApplicationController
  load_and_authorize_resource

  set_tab :database

  def index
    @branches = Branch.accessible_by(current_ability).page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @branches }
    end
  end

  def show
    @branch = Branch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @branch }
    end
  end

  def new
    @branch = Branch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @branch }
    end
  end

  def edit
    @branch = Branch.find(params[:id])
  end

  def create
    @branch = Branch.new(params[:branch])

    respond_to do |format|
      if @branch.save
        format.html { redirect_to(branches_path, :notice => 'Branch was successfully created.') }
        format.xml  { render :xml => @branch, :status => :created, :location => @branch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @branch.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @branch = Branch.find(params[:id])

    respond_to do |format|
      if @branch.update_attributes(params[:branch])
        format.html { redirect_to(@branch, :notice => 'Branch was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @branch.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @branch = Branch.find(params[:id])
    @branch.destroy

    respond_to do |format|
      format.html { redirect_to(branches_url, :notice => 'Branch has been deleted.') }
      format.xml  { head :ok }
    end
  end
end
