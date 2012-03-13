class DirectionalController < ApplicationController

  def index
    @branch = Branch.accessible_by(current_ability).first
    @directional = Directional.new(Date.today.beginning_of_month, Date.today, @branch)
  end
end
