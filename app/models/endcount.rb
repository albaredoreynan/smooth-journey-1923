class Endcount
  include ActiveSupport

  attr_accessor :beginning_date, :ending_date
  attr_accessor :items

  def initialize(items, ending_date, beginning_date=nil)
    @ending_date = ending_date.to_date
    @beginning_date = beginning_date || @ending_date.beginning_of_month
    @items = process_items(items)
  end

  def self.ending_counts_at(items, date=Date.today)
    items.each do |item|
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
