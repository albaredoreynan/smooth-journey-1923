require 'spec_helper'

describe Reports::PurchaseReportsController do

  it 'should route to purhase reports' do
    { get: 'reports/purchases' }.
      should route_to(controller: 'reports/purchase_reports', action: 'index')
  end
end
