class ItemCount < ActiveRecord::Base
  attr_accessor :settings

  belongs_to :endcount
  belongs_to :item
  belongs_to :unit

  before_save :set_item_unit

  def quantity
    Quantity.new(self[:stock_count], unit ||= item.unit)
  end

  def locked?
    return true if self.settings.nil?
    enable_lock_module = self.settings[:enable_lock_module]
    lock_module_in = self.settings[:lock_module_in].to_i

    unless self[:created_at].nil?
      enable_lock_module && self[:created_at] < lock_module_in.hours.ago
    else
      false
    end
  end

  private
  def set_item_unit
    self.unit = item.unit if self.unit.nil?
  end
end
