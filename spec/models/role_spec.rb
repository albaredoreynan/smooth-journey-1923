require 'spec_helper'

describe Role do
  context 'Validation' do
    it 'should be invalid without name' do
      role = Role.new
      role.should have_at_least(1).error_on :name
    end

    it 'should have a valid role name' do
      Role::VALID_ROLES.each do |role|
        role = Role.new(:name => role)
        role.should be_valid
      end
    end
  end

  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :branch }
  end
end
