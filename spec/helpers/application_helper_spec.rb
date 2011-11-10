require 'spec_helper'

describe ApplicationHelper do

  it 'should display correct title' do
    helper.title.should eq 'RRBS'
  end
end
