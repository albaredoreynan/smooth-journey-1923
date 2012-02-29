class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :username, :branch_id
  attr_accessor :role, :branch_id

  has_many :roles
  has_many :branches, :through => :roles
  has_many :companies, :through => :roles

  validates :username, :presence => true, :uniqueness => true

  after_save :set_roles, :if => Proc.new { |user| user.roles.count == 0 }

  Role::VALID_ROLES.each do |role_name|
    define_method "#{role_name}?" do
      roles.where(:name => role_name).exists?
    end
  end

  def settings
    if branch?
      branches.first.settings
    elsif client?
      companies.first.settings
    end
  end

  def self.filter_by_company(company_id)
    joins(:roles => :company).where('companies.id = ?', company_id)
  end

  private
  def set_roles
    roles.create(:name => @role, :branch_id => @branch_id)
  end
end
