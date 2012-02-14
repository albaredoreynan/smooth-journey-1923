require 'spec_helper'

describe Purchase do

  context '#supplier_name' do
    it 'should return a supplier name' do
      supplier = FactoryGirl.create(:supplier, :name => 'Sena the Accessorizer')
      purchase = FactoryGirl.create(:purchase, :supplier => supplier)
      purchase.supplier_name.should eq 'Sena the Accessorizer'
    end

  end

  context 'calculator methods' do
    before do
      @purchase = FactoryGirl.create(:purchase)
      @purchase_items = [
        FactoryGirl.create(:purchase_item, :purchase => @purchase, :amount => 5, :vat_type => 'VAT-Exclusive'),
        FactoryGirl.create(:purchase_item, :purchase => @purchase, :amount => 5, :vat_type => 'VAT-Inclusive'),
        FactoryGirl.create(:purchase_item, :purchase => @purchase, :amount => 5, :vat_type => 'VAT-Exempted')
      ]
    end

    describe '.vat_amount' do
      it 'should return 0 when no purchase items' do
        purchase = FactoryGirl.create(:purchase)
        purchase.vat_amount.should eq 0
      end

      it 'should return total vat_amount' do
        @purchase.vat_amount.should be_between(1.135, 1.136)
      end
    end

    describe '.net_amount' do
      it 'should return 0 when no purchase items' do
        purchase = FactoryGirl.create(:purchase)
        purchase.net_amount.should eq 0
      end

      it 'should return total net_amount' do
        @purchase.net_amount.should be_between(14.464, 14.465)
      end
    end

    describe '.amount' do
      it 'should return 0 when no purchase items' do
        purchase = FactoryGirl.create(:purchase)
        purchase.amount.should eq 0
      end

      it 'should return total amount' do
        @purchase.amount.should eq 15
      end
    end
  end

  context 'Validation' do
    it { should validate_presence_of :branch_id }
    it { should validate_presence_of :purchase_date }
    it { should validate_presence_of :supplier_id }
  end

  context 'Search' do
    before do
      supplier = FactoryGirl.create(:supplier, :name => 'Boy 1')
      @purchase1 = FactoryGirl.create(:purchase, :invoice_number => '12345', :supplier => supplier, :purchase_date => Date.today)
      @purchase2 = FactoryGirl.create(:purchase, :purchase_date => 5.days.ago)
      @start_date = 6.days.ago
      @end_date = Date.today
    end

    it 'should search invoice number' do
      Purchase.search(:invoice_number => '12345').should eq [@purchase1]
      Purchase.search(:invoice_number => '6789').should be_empty
    end

    it 'should search supplier name' do
      Purchase.search(:supplier => 'Boy 1').should eq [@purchase1]
      Purchase.search(:supplier => 'boy 1').should eq [@purchase1]
      Purchase.search(:supplier => 'Boy 2').should be_empty
    end

    it 'should search purchase by date' do
      results = Purchase.search(:start_date => @start_date, :end_date => @end_date)
      results.should eq [@purchase1, @purchase2]
    end

    it 'should search purchase by date as string' do
      start_date = @start_date.strftime('%F')
      end_date = @end_date.to_s
      results = Purchase.search(:start_date => start_date, :end_date => end_date)
      results.should eq [@purchase1, @purchase2]
    end
  end
end
