require 'spec_helper'

describe "purchases/show.html.erb" do
  before(:each) do
    @purchase = assign(:purchase, stub_model(Purchase,
      :invoice_number => 1,
      :supplier_id => 1,
      :branch_id => 1,
      :save_as_draft => 1
    ))
  end

  it "renders attributes in <p>" do
    pending 'fail'
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
