class Item < ActiveRecord::Base

  attr_accessor :beginning_count, :ending_count

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  belongs_to :subcategory
  has_many :purchase_items
  has_many :item_counts

  after_save :new_item_count, :if => :new_record? do
    item_counts.create(:stock_count => 0.00)
  end

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
    unless new_record?
      today_count = item_counts.find_or_initialize_by_entry_date(Date.today)
      today_count.update_attribute(:stock_count, count)
    end
  end

  def counted_at(date)
    if date.is_a?(String)
      date = Date.parse(date)
    end
    item_counts.where('entry_date = ?', date).try(:first)
  end

  def self.endcount(beginning_date, ending_date)
    Item.all.each do |item|
      item.beginning_count = item.counted_at(beginning_date)
      item.ending_count = item.counted_at(ending_date)
    end
  end
end
