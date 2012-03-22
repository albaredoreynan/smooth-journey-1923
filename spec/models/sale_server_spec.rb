require 'spec_helper'

describe SaleServer do
  context 'Association' do
    it { should belong_to :sale }
    it { should belong_to :server }
  end
end
