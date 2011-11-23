class Item < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  belongs_to :subcategory
  has_many :purchase_items
  has_many :item_counts
  has_many :endcounts, :through => :item_counts

  def self.search(keyword)
    where("name ILIKE ?", '%'+keyword+'%')
  end

  def category_name
    subcategory.category.name unless subcategory.nil?
  end

  def subcategory_name
    subcategory.name unless subcategory.nil?
  end

  def end_count
    unless endcounts.empty?
      end_count = endcounts.order('end_date DESC').first
      end_count.item_counts.order('created_at DESC').first.end_count
    else
      0
    end
  end
end
