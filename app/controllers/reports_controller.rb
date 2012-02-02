class ReportsController < ApplicationController

  def render_csv(filename = nil)
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers['Content-Type'] = 'text/plain'
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Expires'] = "0"
    end
    headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""

    render :layout => false
  end
end
