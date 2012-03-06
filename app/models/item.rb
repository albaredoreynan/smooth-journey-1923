class Item < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  belongs_to :subcategory
  belongs_to :restaurant
  has_many :purchase_items
  has_many :item_counts

  default_scope order('name ASC')

  scope :inventory, where(:non_inventory => false)

  after_save :new_item_count, :if => :new_record? do
    item_counts.create(:stock_count => 0.00)
  end

  delegate :symbol, :to => :unit, :prefix => true

  def self.search(keyword)
    where("name ILIKE ?", "%#{keyword}%")
  end

  def branch_location
    branch.location if branch
  end

  def unit_name
    unit.name || unit.symbol
  end

  def category_name
    subcategory.category.name if subcategory
  end

  def subcategory_name
    subcategory.name if subcategory
  end

  def item_count
    item_counts.order('entry_date DESC, updated_at DESC').try(:first).try(:stock_count) || 0
  end

  def item_count=(count)
    self.update_count(count)
  end

  def update_count(count, date=Date.today, branch=nil)
    unless new_record?
      today_count = item_counts.find_or_initialize_by_entry_date(date)
      today_count.stock_count = count
      today_count.branch = branch
      today_count.save
    end
  end

  def counted_at(date, branch=nil)
    item_counts.where('entry_date = ?', date.to_date).order('created_at DESC').try(:first) || ItemCount.new
  end

  def available_units
    units = [ unit ]
    Conversion.where(:smaller_unit_id => unit.id).each do |conversion|
      units << conversion.bigger_unit
    end
    return units
  end
end
