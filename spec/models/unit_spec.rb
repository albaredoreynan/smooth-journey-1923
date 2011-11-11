require 'spec_helper'

describe Unit do

  context 'Validation' do
    it 'should be invalid without name' do
      unit = Unit.new
      unit.should have(1).error_on :unit_name
    end
  end
end

