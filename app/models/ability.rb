class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    role_name = user.roles.try(:first).try(:name)
    case role_name
    when 'branch'
      branch = user.branches.first

      # Purchase
      can :new, Purchase
      can [:read, :create], Purchase, :branch_id => branch.id
      can [:update, :edit], Purchase do |purchase|
        purchase.branch == branch
      end

      cannot [:edit, :update], Purchase do |purchase|
        setting = user.settings
        seconds_in_minute = 60
        purchase.created_at < Time.now - setting['lock_module_in'].to_i * seconds_in_minute
      end
      cannot [:edit, :update], Purchase , :branch_id => branch.id
      
      can :manage, PurchaseItem, :purchase => { :branch_id => branch.id }
      
      # Inventory Item
      can :manage, Endcount
      can :manage, [EndcountItem, Item], :restaurant_id => branch.restaurant.id
      can :update_count, Item do |item|
        item.entry_date < Date.today - 1.day && item.branch == branch
      end

      # Item
      cannot [:create, :destroy, :edit, :update], Item

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

      # Sale
      can :manage, Sale, :branch_id => branch.id
      
      # Sales Category
      can :read, SaleCategory, :restaurant_id => branch.restaurant
      
      # Settlement Type
      can :read, SettlementType, :restaurant_id => branch.restaurant
      cannot [:create, :edit, :update, :destroy], SettlementType, :restaurant_id => branch.restaurant

      # Server
      can :read, Server, :branch_id => branch.id
      cannot [:create, :edit, :update, :destroy], Server, :branch_id => branch.id

      # Subcategory
      can :read, Subcategory, :category => { :restaurant_id => branch.restaurant }
      cannot [:create, :edit, :update, :destroy], Subcategory, :category => { :restaurant_id => branch.restaurant }

      # Supplier
      can :read, Supplier, :company => { :id => branch.restaurant.company.id }
      cannot [:create, :edit, :update, :destroy], Supplier, :company => { :id => branch.restaurant.company.id }

      # Unit
      can :read, Unit, :restaurant_id => branch.restaurant
      cannot [:create, :edit, :update, :destroy], Unit, :restaurant_id => branch.restaurant

      can :read, User, :roles => { :company => { :id => user.roles.first.company.id } }
      # only allow edit his own user info
      can [:edit, :update], User do |usr|
        user == usr
      end
      
      cannot [:create, :destroy], User, :roles => { :company => { :id => user.roles.first.company.id } }
       
      can :manage, Employee, :branch_id => branch.id
      can :manage, LaborHour, :employee => { :branch_id => branch.id }
      can [:create, :edit, :update, :destroy], LaborHour

      cannot :manage, AmountMultiplier

    when 'client'
      #company_id = user.companies.first.id
      #can [:read, :edit, :update], Company, :id => company_id
      #can :new,    Branch
      #can :manage, Branch, :restaurant => { :company => { :id => company_id } }
      #can [:new, :create], Category
      #can :manage, Category, :restaurant => { :company => { :id => company_id } }
      #can :manage, Conversion
      #can :manage, Endcount
      #can :manage, [ EndcountItem ], :restaurant => { :company => { :id => company_id } }
      #can :manage, [ Item ], :restaurant => { :company => { :id => company_id } }
      #can :manage, Purchase, :branch => { :restaurant => { :company => { :id => company_id } } }
      #can :manage, PurchaseItem, :purchase => { :branch => { :restaurant => { :company => { :id => company_id } } } }
      #can :manage, Restaurant, :company_id => company_id
      #can :manage, Sale, :branch => { :restaurant => { :company => { :id => company_id } } }
      #can :manage, Server, :branch => { :restaurant => { :company => { :id => company_id } } }
      #can [:new, :create], Server
      #can :manage, SaleCategory, :restaurant => { :company_id => company_id }
      #can :manage, SettlementType, :restaurant => { :company => { :id => company_id } } 
      #can [:new, :create], Subcategory
      #can :manage, Subcategory, :category => { :restaurant => { :company => { :id => company_id } } }
      #can [:new, :create], SettlementType
      #can :manage, SettlementType, :restaurant => { :company => { :id => company_id } } 
      #can :manage, Supplier, :company_id =>  company_id
      #can :new,    Unit
      #can :manage, Unit, :restaurant => { :company => { :id => company_id } }
      #can :new,    Users
      #can :manage, User, :roles => { :company => { :id => company_id } }
      #can :manage, Unit, :restaurant => { :company => { :id => company_id } }
      
      can :manage, :all
      
      
    when 'accounting'
      can [:index, :read], :all

    when 'admin'
      can :manage, :all
    end
  end
end
