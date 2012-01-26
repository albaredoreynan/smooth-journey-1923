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
      can [:read, :create], Purchase, :branch_id => user.branches.first.id
      can :update, Purchase do |purchase|
        purchase.save_as_draft || purchase.branch == user.branches.first
      end

      cannot [:edit, :update], Purchase do |purchase|
        setting = user.settings
        seconds_in_minute = 60
        purchase.created_at < Time.now - setting[:lock_module_in] * seconds_in_minute
      end

      # Inventory Item
      can :manage, Endcount
      can :manage, [ Item, EndcountItem ], :branch_id => user.branches.first.id
      can :update_count, Item do |item|
        item.entry_date < Date.today - 1.day
      end

      # Category
      can :manage, Category, :restaurant_id => user.branches.first.restaurant
    end

    if user.client?
      can [:read, :edit, :update], Company, :id => user.companies.first.id
      can :new,    Branch
      can :manage, Branch, :restaurant => { :company => { :id => user.companies.first.id } }
      can :new, Category
      can :manage, Category, :restaurant => { :company => { :id => user.companies.first.id } }
      can :manage, Endcount
      can :manage, [ Item, EndcountItem ], :branch => { :restaurant => { :company => { :id => user.companies.first.id } } }
      can :manage, Restaurant, :company_id => user.companies.first.id
      can [:new, :create], Subcategory
      can :manage, Subcategory, :category => { :restaurant => { :company => { :id => user.companies.first.id } } }
      can :new, Unit
      can :manage, Unit, :restaurant => { :company => { :id => user.companies.first.id } }
    end

    if user.admin?
      can :manage, :all
    end

  end
end
