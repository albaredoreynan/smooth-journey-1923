class Item < ActiveRecord::Base

  attr_accessor :beginning_count, :ending_count

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  belongs_to :subcategory
  has_many :purchase_items
  has_many :item_counts

  after_save :new_item_count, :if => :new_record? do
    item_counts.create(:stock_count => 0)
  end

  def self.search(keyword)
    where("name ILIKE ?", "%#{keyword}%")
  end

  def category_name
    subcategory.category.name unless subcategory.nil?
  end

  def subcategory_name
    subcategory.name unless subcategory.nil?
  end

  def item_count
    item_counts.order('entry_date DESC').try(:first).try(:stock_count) || 0
  end

  def item_count=(count, entry_date=Time.now)
    unless new_record?
      item_counts.create(:stock_count => count, :entry_date => entry_date)
    end
  end

  def counted_at(date)
    if date.is_a?(String)
      date = Date.parse(date)
    end
    begin_date = date.midnight
    end_date = (date + 1.day).midnight
    item_counts.where('entry_date >= :date and entry_date < :next_day',
      { :date => begin_date,
        :next_day => end_date }).try(:first).try(:stock_count) || '-'
  end

  def self.endcount(beginning_date, ending_date)
    Item.all.each do |item|
      item.beginning_count = item.counted_at(beginning_date)
      item.ending_count = item.counted_at(ending_date)
    end
  end
end
