class Ability
  include CanCan::Ability

  def initialize(user)
    role_name = user.roles.first.name
    case role_name
    when 'branch'
            
      branch = user.branches.first
      
      # Purchase
      can :new, Purchase
      can [:read, :create], Purchase, :branch_id => branch.id
      can :update, Purchase do |purchase|
        purchase.branch == branch
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
      
      # Branch
      can :read, Branch, :id => branch.id
      cannot [:create, :destroy, :edit, :update], Branch, :id => branch.id
      
      # Category
      can :read, Category, :restaurant_id => branch.restaurant
      cannot [:create, :edit, :update, :destroy], Category, :restaurant_id => branch.restaurant
      
      # Conversion
      can :read, Conversion
      cannot [:create, :edit, :update, :destroy], Conversion
      
      # Currency
      can :read, Currency
      cannot [:create, :edit, :update, :destroy], Currency
      
      # Settlement Type
      can :read, SettlementType, :branch_id => branch.id
      cannot [:create, :edit, :update, :destroy], SettlementType, :branch_id => branch.id 

      # Subcategory
      can :read, Subcategory, :category => { :restaurant_id => branch.restaurant }
      cannot [:create, :edit, :update, :destroy], Subcategory, :category => { :restaurant_id => branch.restaurant }
      
      # Supplier
      can :read, Supplier, :company => { :id => branch.restaurant.company.id }
      cannot [:create, :edit, :update, :destroy], Supplier, :company => { :id => branch.restaurant.company.id }
      
      # Unit
      can :read, Unit, :restaurant_id => branch.restaurant
      cannot [:create, :edit, :update, :destroy], Unit, :restaurant_id => branch.restaurant
      
      can :read, User, :company_id => user.roles.first.company_id
      cannot [:create, :edit, :update, :destroy], User, :company_id => user.roles.first.company_id
      
    when 'client'
      company_id = user.companies.first.id
      can [:read, :edit, :update], Company, :id => company_id
      can :new,    Branch
      can :manage, Branch, :restaurant => { :company => { :id => company_id } }
      can [:new, :create], Category
      can :manage, Category, :restaurant => { :company => { :id => company_id } }
      can :manage, Conversion
      can :manage, Endcount
      can :manage, [ Item, EndcountItem ], :branch => { :restaurant => { :company => { :id => company_id } } }
      can :manage, Purchase, :branch => { :restaurant => { :company => { :id => company_id } } }
      can :manage, PurchaseItem, :purchase => { :branch => { :restaurant => { :company => { :id => company_id } } } }
      can :manage, Restaurant, :company_id => company_id
      can [:new, :create], Subcategory
      can :manage, Subcategory, :category => { :restaurant => { :company => { :id => company_id } } }
      can [:new, :create], SettlementType
      can :manage, SettlementType, :branch => { :restaurant => { :company => { :id => company_id } } }
      can :manage, Supplier, :company_id =>  company_id
      can :new, Unit
      can :manage, Unit, :restaurant => { :company => { :id => company_id } }
      can :new, User
      can :manage, User, :company_id => user.roles.first.company_id
    when 'admin'
      can :manage, :all
    end

  end
end
