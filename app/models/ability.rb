class Ability
  include CanCan::Ability

  def initialize(user)
    if user.branch?
      # Branch
      can :read, Branch, :id => user.branches.first.id
      can :update, Branch do |branch|
        user.branches.first == branch
      end
      cannot [:create, :destroy], Branch

      # Purchase
      can :new, Purchase
      can [:read, :edit, :create], Purchase, :branch_id => user.branches.first.id
      can :update, Purchase do |purchase|
        purchase.save_as_draft || purchase.branch == user.branches.first
      end
      cannot :update, Purchase do |purchase|
        purchase.created_at < Time.now - 1.day
      end
      
      # within_day = Time.now - 1.day
#       
      # if Purchase.created_at? within_day
        # can :update, Purchase, :branch_id => user.branches.first.id
      # end
      # Inventory Item
      can :manage, Item, :branch_id => user.branches.first.id

      # Category
      can :manage, Category, :restaurant_id => user.branches.first.restaurant
    end
    if user.admin?
      can :manage, :all
    end
    
  end
end
