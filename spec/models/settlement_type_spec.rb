require 'spec_helper'

describe SettlementType do

  context 'Validation' do
    it 'should be invalid without name' do
      settlement_type = SettlementType.new
      settlement_type.should have(1).error_on :name
    end
  end
end
