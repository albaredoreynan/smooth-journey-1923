require 'spec_helper'

describe Server do

  context 'Validation' do
    before do
      @server = Server.new
    end

    it 'should be invalid without name' do
      @server.should have(1).error_on :name
    end

    it 'should be invalid without branch' do
      @server.should have(1).error_on :branch_id
    end
  end

  context 'Association' do
    it { should belong_to :branch }
  end
end
