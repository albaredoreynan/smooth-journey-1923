require 'spec_helper'

describe Supplier do

  context 'Validation' do
    before do
      @supplier = Supplier.new
    end

    it 'should be invalid withou name' do
      @supplier = Supplier.new
      @supplier.should have(1).error_on :name
    end

    it 'should be valid without email' do
      @supplier.email = ''
      @supplier.should have(0).error_on :email
    end

    it 'should accept valid email address' do
      %w[user@example.com user@foo.bar.org user.name@example.ph].each do |email|
        @supplier.email = email
        @supplier.should have(0).error_on :email
      end
    end

    it 'should reject invalid email address' do
      %w[user@foo,com user_at_foo.org example.user@foo.].each do |email|
        @supplier.email = email
        @supplier.should have_at_least(1).error_on :email
      end
    end
  end
end
