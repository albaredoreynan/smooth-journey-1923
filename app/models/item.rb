class Item < ActiveRecord::Base

  attr_accessor :beginning_count, :ending_count

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  belongs_to :subcategory
  has_many :purchase_items
  has_many :item_counts

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
    item_counts.order('created_at DESC').try(:first).try(:stock_count) || 0
  end

  def item_count=(count)
    # get previous count and check how many is changed
    previous_count = item_count
    item_counts.create(:stock_count => count)
  end

  def count_at(date)
    if date.is_a?(String)
      date = Date.parse(date)
    end
    begin_date = date.midnight
    end_date = (date + 1.day).midnight
    item_counts.where('created_at >= :date and created_at < :next_day',
      { :date => begin_date,
        :next_day => end_date }).try(:first).try(:stock_count) || '-'
  end
end
