# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120304152328) do

  create_table "branches", :force => true do |t|
    t.integer  "restaurant_id"
    t.string   "location"
    t.string   "contact_number"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "categories", ["restaurant_id"], :name => "index_categories_on_restaurant_id"

  create_table "category_sales", :force => true do |t|
    t.integer  "sale_id",     :null => false
    t.integer  "category_id", :null => false
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "category_sales", ["category_id"], :name => "index_csrows_on_category_id"
  add_index "category_sales", ["sale_id"], :name => "index_csrows_on_sale_id"

  create_table "categorysales", :force => true do |t|
    t.float    "cs_amount"
    t.integer  "employee_id"
    t.float    "vat"
    t.float    "void"
    t.float    "servicecharge"
    t.float    "cs_revenue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "cs_date"
    t.integer  "customer_count"
    t.integer  "transaction_count"
    t.integer  "save_as_draft"
    t.float    "cs_total_amount"
    t.integer  "category_id"
    t.datetime "deleted_at"
  end

  add_index "categorysales", ["employee_id"], :name => "employee_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "contact_number"
    t.text     "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "conversions", :force => true do |t|
    t.integer  "bigger_unit_id"
    t.integer  "smaller_unit_id"
    t.float    "conversion_factor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "currencies", :force => true do |t|
    t.string   "currency"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "department_name"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "branch_id"
    t.date     "date_employed"
    t.integer  "job_id"
    t.integer  "department_id"
    t.date     "birthdate"
    t.string   "contact_number"
    t.string   "sss"
    t.string   "tin"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "endcounts", :force => true do |t|
    t.date     "begin_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "save_as_draft"
    t.datetime "deleted_at"
  end

  create_table "item_counts", :force => true do |t|
    t.integer  "item_id"
    t.integer  "unit_id"
    t.float    "stock_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "entry_date"
    t.datetime "deleted_at"
  end

  add_index "item_counts", ["unit_id"], :name => "index_item_counts_on_unit_id"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "unit_id"
    t.string   "item_type"
    t.integer  "subcategory_id"
    t.boolean  "non_inventory"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "restaurant_id"
  end

  add_index "items", ["branch_id"], :name => "index_items_on_branch_id"
  add_index "items", ["restaurant_id"], :name => "index_items_on_restaurant_id"
  add_index "items", ["subcategory_id"], :name => "index_items_on_subcategory_id"
  add_index "items", ["unit_id"], :name => "index_items_on_unit_id"

  create_table "jobs", :force => true do |t|
    t.string   "job_name"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "purchase_items", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "item_id"
    t.integer  "unit_id"
    t.float    "unit_cost"
    t.float    "quantity"
    t.float    "amount"
    t.text     "vat_type"
    t.string   "particulars"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "purchase_items", ["item_id"], :name => "index_purchaserows_on_item_id"
  add_index "purchase_items", ["purchase_id"], :name => "index_purchaserows_on_purchase_id"
  add_index "purchase_items", ["unit_id"], :name => "index_purchaserows_on_unit_id"

  create_table "purchases", :force => true do |t|
    t.date     "purchase_date"
    t.string   "invoice_number"
    t.integer  "supplier_id"
    t.integer  "branch_id"
    t.boolean  "save_as_draft"
    t.integer  "currency_id"
    t.text     "vat_type"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "purchases", ["created_by_id"], :name => "index_purchases_on_created_by_id"

  create_table "reporttemplates", :force => true do |t|
    t.string   "report_name"
    t.text     "report_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "restaurantcategories", :force => true do |t|
    t.string   "category_listName"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.text     "description"
    t.integer  "currency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "roles", ["branch_id"], :name => "index_roles_on_branch_id"
  add_index "roles", ["company_id"], :name => "index_roles_on_company_id"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "sale_categories", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sale_categories", ["company_id"], :name => "index_sale_categories_on_company_id"

  create_table "sale_category_rows", :force => true do |t|
    t.integer  "category_id"
    t.integer  "sale_id"
    t.decimal  "amount"
    t.datetime "deleted_at"
  end

  add_index "sale_category_rows", ["category_id"], :name => "index_sale_category_rows_on_sale_category_id"
  add_index "sale_category_rows", ["sale_id"], :name => "index_sale_category_rows_on_sale_id"

  create_table "sales", :force => true do |t|
    t.integer  "employee_id"
    t.float    "vat"
    t.float    "void"
    t.date     "date"
    t.float    "revenue_ss"
    t.integer  "customer_count"
    t.integer  "transaction_count"
    t.float    "gross_total_ss"
    t.float    "net_total_ss"
    t.integer  "dinein_cc"
    t.integer  "dinein_tc"
    t.float    "dinein_ppa"
    t.float    "delivery_sales"
    t.integer  "delivery_tc"
    t.float    "delivery_pta"
    t.integer  "takeout_tc"
    t.float    "takeout_pta"
    t.float    "total_amount_cs"
    t.float    "total_revenue_cs"
    t.integer  "branch_id"
    t.float    "service_charge"
    t.integer  "save_as_draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "dinein_pta",        :null => false
    t.datetime "deleted_at"
  end

  create_table "settings", :force => true do |t|
    t.integer  "company_id"
    t.boolean  "enable_lock_module"
    t.integer  "lock_module_in"
    t.datetime "deleted_at"
  end

  add_index "settings", ["company_id"], :name => "index_settings_on_company_id"

  create_table "settlement_sales", :force => true do |t|
    t.integer  "employee_id",      :null => false
    t.float    "vat"
    t.float    "void"
    t.date     "ss_date"
    t.float    "ss_revenue"
    t.integer  "customerCount"
    t.integer  "transactionCount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_type"
    t.float    "gross_total"
    t.float    "net_total"
    t.integer  "save_as_draft",    :null => false
    t.integer  "dinein_cc",        :null => false
    t.integer  "dinein_tc",        :null => false
    t.float    "dinein_ppa",       :null => false
    t.float    "dinein_pta",       :null => false
    t.float    "delivery_sales",   :null => false
    t.float    "delivery_tc",      :null => false
    t.float    "delivery_pta",     :null => false
    t.integer  "takeout_tc",       :null => false
    t.float    "takeout_pta",      :null => false
    t.datetime "deleted_at"
  end

  create_table "settlement_type_sales", :force => true do |t|
    t.integer  "settlement_type_id"
    t.float    "amount"
    t.integer  "sale_id"
    t.date     "created_at",         :null => false
    t.date     "updated_at",         :null => false
    t.datetime "deleted_at"
  end

  add_index "settlement_type_sales", ["sale_id"], :name => "index_ssrows_on_sale_id"

  create_table "settlement_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.datetime "deleted_at"
  end

  create_table "subcategories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "suppliers", :force => true do |t|
    t.integer  "branch_id"
    t.string   "name"
    t.string   "email"
    t.text     "address"
    t.text     "description"
    t.string   "contact_number"
    t.string   "contact_person"
    t.integer  "company_id"
    t.string   "tin"
    t.string   "mobile_number"
    t.string   "contact_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "units", :force => true do |t|
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "unit_type"
    t.integer  "restaurant_id"
    t.datetime "deleted_at"
  end

  add_index "units", ["restaurant_id"], :name => "index_units_on_restaurant_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "password_salt",                         :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
