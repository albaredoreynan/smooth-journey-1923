class Role < ActiveRecord::Base

  VALID_ROLES = %w{admin client branch}

  validates :name, :inclusion => { :in => VALID_ROLES }

  belongs_to :user
  belongs_to :branch
  belongs_to :company
end
