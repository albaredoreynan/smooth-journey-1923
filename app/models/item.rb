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
    item_counts.order('created_at DESC').try(:first).try(:count) || 0
  end

  def item_count=(count)
    # get previous count and check how many is changed
    previous_count = item_count
    delta = count - previous_count
    item_counts.create(:count => count, :delta => delta)
  end

  def end_count=(count)
    @end_count = count
  end

  def self.end_counts(begin_date, end_date)
    Item.where(:created_at => [begin_date, end_date])
  end
end
