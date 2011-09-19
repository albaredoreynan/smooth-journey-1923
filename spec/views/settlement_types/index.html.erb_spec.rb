require 'spec_helper'

describe "settlement_types/index.html.erb" do
  before(:each) do
    assign(:settlement_types, [
      stub_model(SettlementType,
        :st_name => "St Name"
      ),
      stub_model(SettlementType,
        :st_name => "St Name"
      )
    ])
  end

  it "renders a list of settlement_types" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "St Name".to_s, :count => 2
  end
end
