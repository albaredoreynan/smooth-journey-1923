class Item < ActiveRecord::Base

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
    delta = count - previous_count
    item_counts.create(:stock_count => count, :delta => delta)
  end

  def beginning_count(begin_date)
    if begin_date.is_a?(String)
      begin_date = Date.parse(begin_date)
    end
    item_counts.where('created_at >= :begin_date and created_at < :next_day',
      { :begin_date => begin_date.midnight,
        :next_day => (begin_date + 1.day)
      .strftime('%F') }).try(:first).try(:stock_count) || '-'
  end

  def ending_count(end_date)
    beginning_count(end_date)
  end
end
