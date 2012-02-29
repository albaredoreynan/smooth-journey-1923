class Ability
  include CanCan::Ability

  def initialize(user)
    role_name = user.roles.first.name
    case role_name
    when 'branch'
      #Database Module
      #supplier
      can :read, Supplier, :company_id => user.branches.first.id
      cannot [:create, :edit, :update, :destroy], Supplier, :company_id => user.branches.first.id
      
      #categories
      can :read, Category, :restaurant => { :company => { :id => user.branches.first.id} }
      cannot [:create, :edit, :update, :destroy], Category, :restaurant => { :company => { :id => user.branches.first.id} }
      
      #subcategories
      can :read, Subcategory, :category => {:restaurant => { :company => { :id => user.branches.first.id } } }
      cannot [:create, :edit, :update, :destroy], Subcategory, :category => {:restaurant => { :company => { :id => user.branches.first.id } } }
      
      # Branch
      branch = user.branches.first
      #company = branch.restaurant.company
      can :read, Branch, :id => branch.id

      can :update, Branch do |branch|
        user.branches.first == branch
      end
      cannot [:create, :destroy], Branch

      # Purchase
      can :new, Purchase
      can [:read, :create], Purchase, :branch_id => branch.id
      can :update, Purchase do |purchase|
        purchase.save_as_draft || purchase.branch == branch
      end

      cannot [:edit, :update], Purchase do |purchase|
        setting = user.settings
        seconds_in_minute = 60
        purchase.created_at < Time.now - setting[:lock_module_in].to_i * seconds_in_minute
      end

      # Inventory Item
      can :manage, Endcount
      can :manage, [ Item, EndcountItem ], :branch_id => branch.id
      can :update_count, Item do |item|
        item.entry_date < Date.today - 1.day
      end

      # Category
      can :manage, Category, :restaurant_id => branch.restaurant
      can :manage, Supplier, :company => { :id => branch.restaurant.company.id }
      
    when 'client'
      company_id = user.companies.first.id
      can [:read, :edit, :update], Company, :id => company_id
      can :new,    Branch
      can :manage, Branch, :restaurant => { :company => { :id => company_id } }
      can :new, Category
      can :manage, Category, :restaurant => { :company => { :id => company_id } }
      can :manage, Endcount
      can :manage, [ Item, EndcountItem ], :branch => { :restaurant => { :company => { :id => company_id } } }
      can :manage, Purchase
      can :manage, Restaurant, :company_id => company_id
      can [:new, :create], Subcategory
      can :manage, Subcategory, :category => { :restaurant => { :company => { :id => company_id } } }
      can :manage, SettlementType, :branch => { :restaurant => { :company => { :id => company_id } } }
      can :manage, Supplier, :company_id =>  company_id
      can :new, Unit
      can :manage, Unit, :restaurant => { :company => { :id => company_id } }
    when 'admin'
      can :manage, :all
    end

  end
end
