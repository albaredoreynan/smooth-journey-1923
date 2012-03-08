require 'spec_helper'

describe SettlementTypeSale do
  context 'Validation' do
    before do
      @settlement_type_sale = SettlementTypeSale.new
    end

    it 'should be valid when amount is nil' do
      @settlement_type_sale.amount = nil
      @settlement_type_sale.should have(0).error_on :amount
    end

    it 'should be valid when amount is blank' do
      @settlement_type_sale.amount = ''
      @settlement_type_sale.should have(0).error_on :amount
    end

    it 'should be invalid if amount is not a number' do
      @settlement_type_sale.amount = 'a'
      @settlement_type_sale.should have(1).error_on :amount
    end
  end
end
