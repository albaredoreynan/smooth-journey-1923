class DirectionalController < ApplicationController

  include EndMonth

  set_tab :directional

  before_filter :month_to_date_or_last_day_of_month, :only => :index

  def index
    if current_user.branch?
      @branch = @current_branch
    else
      @branch = params[:branch_id] ? Branch.find(params[:branch_id]) : Branch.accessible_by(current_ability).first
    end
    @directional = Directional.new(Date.today.beginning_of_month, @ending_date, @branch)
    @settlement_type = SettlementType.all(:conditions => ["complimentary != ?", false])
  end
end
