class Role < ActiveRecord::Base

  VALID_ROLES = %w{admin branch}

  validates :name, :inclusion => { :in => VALID_ROLES }

  belongs_to :user
  belongs_to :branch
end
