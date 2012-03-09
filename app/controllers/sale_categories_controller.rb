class SaleCategoriesController < ApplicationController

  set_tab :sales
  set_tab :sale_categories

  def index
    @sale_categories = SaleCategory.accessible_by(current_ability)
  end

  def new
    @sale_category = SaleCategory.new
  end

  def create
    @sale_category = SaleCategory.new(params[:sale_category])

    if @sale_category.save
      redirect_to sale_categories_path, :notice => 'Sale Category has been saved.'
    else
      render :new
    end
  end

  def edit
    @sale_category = SaleCategory.find(params[:id])
    authorize! :edit, @sale_category
  end

  def update
    @sale_category = SaleCategory.find(params[:id])
    authorize! :update, @sale_category

    if @sale_category.update_attributes(params[:sale_category])
      redirect_to sale_categories_path, :notice => 'Sale Category has been saved.'
    else
      render :edit
    end
  end

  def destroy
    @sale_category = SaleCategory.find(params[:id])
    authorize! :delete, @sale_category
    @sale_category.destroy

    redirect_to sale_categories_path
  end
end
