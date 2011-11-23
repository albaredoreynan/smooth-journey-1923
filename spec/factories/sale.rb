FactoryGirl.define do
  factory :sale do
    vat '1'
    void '1'
    date Date.today
    revenue_ss '1'
    customer_count '1'
    transaction_count '1'
    gross_total_ss '1'
    net_total_ss '1'
    dinein_cc '1'
    dinein_tc '1'
    dinein_ppa '1'
    delivery_sales '1'
    delivery_tc '1'
    delivery_pta '1'
    takeout_tc '1'
    takeout_pta '1'
    total_amount_cs '1'
    total_revenue_cs '1'
    service_charge '1'
    dinein_pta '1'
  end
end
