class Endcount
  include ActiveSupport

  attr_accessor :beginning_date, :ending_date
  attr_accessor :items

  def initialize(items, ending_date, beginning_date=nil)
    @ending_date = Date.today.month < ending_date.month ? ending_date.end_of_month : ending_date
    @beginning_date = beginning_date || @ending_date.beginning_of_month
    @items = process_items(items)
  end

  def self.ending_counts_at(items, date=Date.today, branch_id=nil)
    items.each do |item|
      item.branch_id = branch_id
      item.ending_date = date
      item.ending_count || '-'
    end
  end

  private
  def process_items(items)
    endcount_items = []
    items.each do |item|
      item.beginning_date = @beginning_date
      item.ending_date = @ending_date
      endcount_items << item
    end
    return endcount_items
  end
end
