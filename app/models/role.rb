class Role < ActiveRecord::Base

  VALID_ROLES = %w{admin client branch accounting}

  validates :name, :inclusion => { :in => VALID_ROLES }
  validates :user_id, :presence => true

  belongs_to :user
  belongs_to :branch
  belongs_to :company

  after_create :set_company_id

  private
  def set_company_id
    update_attribute(:company_id, branch.company.id) unless branch.nil?
  end
end
