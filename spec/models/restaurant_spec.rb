require 'spec_helper'

describe Restaurant do
  context 'Validation' do
    before do
      @restaurant = Restaurant.new
    end

    it 'should be invalid without store_id' do
      @restaurant.should have_at_least(1).error_on :store_id
    end

    it 'should be invalid on duplicate store_id' do
      Factory.create(:restaurant, :store_id => 1)
      @restaurant.store_id = 1
      @restaurant.should have_at_least(1).error_on :store_id
    end

    it 'should have be invalid without name' do
      @restaurant.should have(1).error_on :name
    end
  end
end
