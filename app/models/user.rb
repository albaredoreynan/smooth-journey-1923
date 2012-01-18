class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  attr_accessor :role

  has_many :roles
  has_many :branches, :through => :roles
  has_many :companies, :through => :roles

  Role::VALID_ROLES.each do |role_name|
    define_method "#{role_name}?" do
      roles.where(:name => role_name).exists?
    end
  end

  def setting
    if branch?
      branches.first.setting
    elsif client?
      companies.first.setting
    end
  end
end
