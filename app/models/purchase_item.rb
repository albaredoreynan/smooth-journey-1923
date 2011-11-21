class PurchaseItem < ActiveRecord::Base
  belongs_to :item

  validates :branch_id, :presence => true
  validates :invoice_id, :presence => true
  validates :amount, :presence => true
  validates :net_amount, :presence => true

  #def self.search(from,to)
      #if from
          #find(:all, :conditions => ['purchase_date LIKE ? or purchase_date LIKE?', "%#{from}%", "%#{to}%"])
      #else
          #find(:all)
      #end
  #end
  def self.search_by_date(start_date,end_date)
    where("purchase_date >= ? and purchase_date <= ?",start_date,end_date).all
  end

end
