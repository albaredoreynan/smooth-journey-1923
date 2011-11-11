require 'spec_helper'

describe "settlement_types/show.html.erb" do
  before(:each) do
    @settlement_type = assign(:settlement_type, stub_model(SettlementType,
      :st_name => "St Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/St Name/)
  end
end
