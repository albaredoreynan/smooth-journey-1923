require 'spec_helper'

describe Supplier do

  context 'Validation' do
    it 'should be invalid withou name' do
      supplier = Supplier.new
      supplier.should have(1).error_on :supplier_name
    end
  end
end
