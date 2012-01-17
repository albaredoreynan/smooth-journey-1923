class ItemCount < ActiveRecord::Base
  attr_accessor :setting

  belongs_to :endcount
  belongs_to :item
  belongs_to :unit

  before_save :set_item_unit

  def quantity
    Quantity.new(self[:stock_count], unit ||= item.unit)
  end

  def locked?
    return true if setting.nil?
    unless self[:created_at].nil?
      self[:created_at] < setting.lock_module_in.hours.ago
    else
      false
    end
  end

  private
  def set_item_unit
    self.unit = item.unit if self.unit.nil?
  end
end
