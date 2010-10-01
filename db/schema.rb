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

ActiveRecord::Schema.define(:version => 20100930205748) do

  create_table "sao_payments", :force => true do |t|
    t.string   "fiscal_year",             :limit => 4
    t.string   "period",                  :limit => 2
    t.string   "agency_code",             :limit => 5
    t.string   "agency_name"
    t.string   "vendor_name"
    t.string   "ap_voucher",              :limit => 8
    t.string   "account_no",              :limit => 6
    t.string   "account_name"
    t.string   "transaction_date"
    t.string   "class_code",              :limit => 5
    t.string   "class_description"
    t.string   "funding_source",          :limit => 5
    t.string   "fund_source_description"
    t.string   "program_code",            :limit => 10
    t.string   "program_description"
    t.string   "item_description"
    t.decimal  "amount",                                :precision => 25, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
