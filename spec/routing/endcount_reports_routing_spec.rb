require 'spec_helper'

describe Reports::EndcountReportsController do
  it 'should route to index' do
    { get: 'reports/endcounts' }.
      should route_to(controller: 'reports/endcount_reports', action: 'index')
  end
end
