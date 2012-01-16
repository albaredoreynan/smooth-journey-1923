class ItemCount < ActiveRecord::Base
  belongs_to :endcount
  belongs_to :item
  belongs_to :unit

  before_save :set_item_unit

  def quantity
    Quantity.new(self[:stock_count], unit ||= item.unit)
  end

  def locked?
    unless self[:created_at].nil?
      self[:created_at] < 1.day.ago
    else
      false
    end
  end

  private
  def set_item_unit
    self.unit = item.unit if self.unit.nil?
  end
end
