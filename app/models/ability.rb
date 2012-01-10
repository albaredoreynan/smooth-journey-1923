class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end
    if user.branch?
      # Branch
      can :read, Branch, :id => user.branches.first.id
      can :update, Branch do |branch|
        user.branches.first == branch
      end
      cannot [:create, :destroy], Branch

      # Purchase
      can :new, Purchase
      can [:read, :update, :edit, :create], Purchase, :branch_id => user.branches.first.id

      # Inventory Item
      can :manage, Item, :branch_id => user.branches.first.id
    end
  end
end
