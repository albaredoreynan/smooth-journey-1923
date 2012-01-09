class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end
    if user.branch?
      can :read, :all
    end
  end
end
