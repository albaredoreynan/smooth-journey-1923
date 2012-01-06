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
      item.ending_count = item.counted_at(date).try(:stock_count) || '-'
    end
  end

  private
  def process_items(items)
    endcount_items = []
    items.each do |item|
      average_unit_cost = item.average_unit_cost
      #item.beginning_count = item.counted_at(@beginning_date).try(:stock_count)
      item.beginning_count = item.last_count_from_previous_month(@beginning_date)
      item.beginning_total = item.beginning_count * average_unit_cost if item.beginning_count
      item.ending_count = item.counted_at(@ending_date).try(:stock_count)
      item.purchase = item.purchase_amount_period(@beginning_date, @ending_date)
      item.ending_total = item.ending_count * average_unit_cost if item.ending_count
      endcount_items << item
    end
    return endcount_items
  end
end
