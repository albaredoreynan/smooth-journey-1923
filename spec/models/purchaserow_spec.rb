require 'spec_helper'

describe Purchaserow do

  context 'Validation' do
    before do
      @purchase_row = Purchaserow.new
    end

    it 'should be invalid without item id' do
      pending
      @purchase_row.should have(1).error_on :item_id
    end
  end

  context '#vat_amount' do
    it 'should calculate vat_amount when vat type is inclusive' do
      purchase_row = FactoryGirl.create(:purchaserow, :amount => 5,
                                                      :vat_type => 'VAT-Inclusive')
      purchase_row.vat_amount.should eq 0.54
    end

    it 'should calculate vat_amount when vat type is exclusive' do
      purchase_row = FactoryGirl.create(:purchaserow, :amount => 5,
                                                      :vat_type => 'VAT-Exclusive')
      purchase_row.vat_amount.should eq 0.6
    end

    it 'should calculate vat_amount when vat type is exempted' do
      purchase_row = FactoryGirl.create(:purchaserow, :amount => 5,
                                                      :vat_type => 'VAT-Exempted')
      purchase_row.vat_amount.should eq 5
    end
  end

  context '#net_amount' do
    it 'should calculate net_amount when vat type is inclusive' do
      purchase_row = FactoryGirl.create(:purchaserow, :amount => 5,
                                                      :vat_type => 'VAT-Inclusive')
      purchase_row.net_amount.should eq 4.46
    end

    it 'should calculate net_amount when vat type is exclusive' do
      purchase_row = FactoryGirl.create(:purchaserow, :amount => 5,
                                                      :vat_type => 'VAT-Exclusive')
      purchase_row.net_amount.should eq 5
    end

    it 'should calculate net_amount when vat type is exempted' do
      purchase_row = FactoryGirl.create(:purchaserow, :amount => 5,
                                                      :vat_type => 'VAT-Exempted')
      purchase_row.net_amount.should eq 5
    end
  end
end
