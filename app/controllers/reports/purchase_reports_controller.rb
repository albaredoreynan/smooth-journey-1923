class Reports::PurchaseReportsController < ReportsController

  set_tab :purchase_reports

  def index
    if params[:start_date].blank? && params[:end_date].blank?
      @start_date = Date.today.beginning_of_month.to_s
      @end_date = Date.today.to_s
    else
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end
    
    
    if current_user.branch?
      branch_id = @current_branch.id
    else
      @branch = Branch.accessible_by(current_ability).first
      branch_id = params[:branch_id] || @branch.id
    end
    
    puts ">>>>date"
    puts @start_date +"--"+ @end_date  
    @purchase_items = PurchaseItem.
      accessible_by(current_ability).
      search(
        :start_date => @start_date,
        :end_date => @end_date,
        :supplier => params[:supplier],
        :invoice_number => params[:invoice_number],
        :item => params[:item],
        :subcategory => params[:subcategory],
        :branch_id => branch_id
      ).
      joins(:purchase).where('purchases.deleted_at IS NULL').group_by do |pi|
      pi.item.subcategory ||= Subcategory.new(:name => '(No subcategory)')
    end
    
    respond_to do |wants|
      wants.html
      wants.csv do
        filename = params[:controller]
        render_csv(filename)
      end
      wants.pdf do
        headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
        render :layout => false
      end
    end
  end
end
