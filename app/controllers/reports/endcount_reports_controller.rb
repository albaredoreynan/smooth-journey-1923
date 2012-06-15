class Reports::EndcountReportsController < ReportsController

  include EndMonth

  set_tab :reports

  before_filter :month_to_date_or_last_day_of_month, :only => :index

  def index
    endcount_items = EndcountItem.
      includes(:subcategory).
      where(current_ability.attributes_for(:read, Item)).
      item_group

    if current_user.branch?
      branch_id = @current_branch.id
    else
      @branch = Branch.accessible_by(current_ability).first
      branch_id = params[:branch_id] || @branch.id
    end

    @endcount = Endcount.new(endcount_items, @ending_date, nil, branch_id)

    respond_to do |wants|
      wants.html
      wants.csv do
        render_csv(params[:controller])
      end
      wants.pdf do
        headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
        render :layout => false
      end
    end
  end
end
