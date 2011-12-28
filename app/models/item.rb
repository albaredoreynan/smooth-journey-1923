class Item < ActiveRecord::Base

  attr_accessor :beginning_count, :beginning_total, :ending_count, :ending_total

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
    self.update_count(count)
  end

  def update_count(count, date=Date.today)
    unless new_record?
      today_count = item_counts.find_or_initialize_by_entry_date(date)
      today_count.update_attribute(:stock_count, count)
    end
  end

  def counted_at(date)
    item_counts.where('entry_date = ?', date.to_date).try(:first)
  end

  def average_unit_cost
    count = purchase_items.count.to_f
    return 0 if count == 0
    purchase_items.map(&:unit_cost).inject(:+).to_f / count
  end

  def self.endcount(beginning_date, ending_date)
    Item.all.each do |item|
      average_unit_cost = item.average_unit_cost
      item.beginning_count = item.counted_at(beginning_date)
      item.beginning_total = item.beginning_count.stock_count * average_unit_cost if item.beginning_count
      item.ending_count = item.counted_at(ending_date)
      # HACK: On some case, when you remove .to_f method on
      # item.ending_count.stock_count, it will crash. ????
      item.ending_total = item.ending_count.stock_count.to_f * average_unit_cost if item.ending_count
    end
  end

  def self.ending_counts_at(date=Date.today)
    Item.all.each do |item|
      item.ending_count = item.counted_at(date).try(:stock_count) || '-'
    end
  end
end
