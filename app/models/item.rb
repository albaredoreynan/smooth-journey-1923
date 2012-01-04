class Item < ActiveRecord::Base

  attr_accessor :beginning_count, :beginning_total, :ending_count, :ending_total, :purchase

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  belongs_to :subcategory
  has_many :purchase_items
  has_many :item_counts

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

  def update_count(count, date=Date.today)
    unless new_record?
      today_count = item_counts.find_or_initialize_by_entry_date(date)
      today_count.update_attribute(:stock_count, count)
    end
  end

  def counted_at(date)
    item_counts.where('entry_date = ?', date.to_date).try(:first)
  end

  def last_count_from_previous_month(date)
    previous_month = date.to_date - 1.month
    sql = %Q{date_part('year', entry_date) = ? and date_part('month', entry_date) = ?}
    count = item_counts.where(sql, previous_month.year, previous_month.month).order('entry_date ASC').first
    count.try(:stock_count)
  end

  def average_unit_cost
    count = purchase_items.count.to_f
    return 0 if count == 0
    arr = []
    purchase_items.each do |pi|
      pi.convert_unit = true
      arr << pi.unit_cost
    end
    arr.inject(:+) / count
  end

  def purchase_amount_period(date_from, date_to)
    purchase_items.joins(:purchase)
      .where('purchases.purchase_date >= ?', date_from.to_date)
      .where('purchases.purchase_date <= ?', date_to.to_date).map(&:net_amount).inject(:+)
  end

  def self.ending_counts_at(date=Date.today)
    Item.all.each do |item|
      item.ending_count = item.counted_at(date).try(:stock_count) || '-'
    end
  end
end
