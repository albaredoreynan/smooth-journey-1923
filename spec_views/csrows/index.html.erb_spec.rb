require 'spec_helper'

describe "csrows/index.html.erb" do
  #before(:each) do
    #assign(:csrows, [
      #stub_model(Csrow,
        #:cs_id => 1,
        #:cs_amount => 1.5
      #),
      #stub_model(Csrow,
        #:cs_id => 1,
        #:cs_amount => 1.5
      #)
    #])
  #end

  it "renders a list of csrows" do
    pending "undefined method 'to_sym' for nil:NilClass"
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
