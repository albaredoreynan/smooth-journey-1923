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
        FactoryGirl.create(:purchase_item, :purchase => @purchase, :amount => 5.00, :vat_type => 'VAT-Exempted'),
        FactoryGirl.create(:purchase_item, :purchase => @purchase, :amount => 5.00, :vat_type => 'VAT-Exempted')
      ]
      @purchase.reload
    end

    context 'no purchase_item' do
      before do
        @no_item_purchase = FactoryGirl.create(:purchase)
      end
      it 'should display 0 when there is no net amount' do
        @no_item_purchase.net_amount.should eq 0.00
      end

      it 'should display 0 when there is no vat_amount' do
        @no_item_purchase.vat_amount.should eq 0.00
      end

      it 'should display 0 when there is no amount' do
        @no_item_purchase.amount.should eq 0.00
      end
    end

    it 'should total net amount' do
      @purchase.amount.should eq 10.00
    end

    it 'should return total net amount' do
      @purchase.net_amount.should eq 10.00
    end

    it 'should return total vat amount' do
      @purchase.vat_amount.should eq 0
    end
  end

  context 'Search' do
    before do
      @purchase1 = FactoryGirl.create(:purchase, :purchase_date => Date.today)
      @purchase2 = FactoryGirl.create(:purchase, :purchase_date => 5.days.ago)
      @start_date = 6.days.ago
      @end_date = Date.today
    end

    it 'should search purchase by date' do
      results = Purchase.search_by_date(@start_date, @end_date)
      results.should eq [@purchase1, @purchase2]
    end

    it 'should search purchase by date as string' do
      start_date = @start_date.strftime('%F')
      end_date = @end_date.to_s
      results = Purchase.search_by_date(start_date, end_date)
      results.should eq [@purchase1, @purchase2]
    end
  end
end
