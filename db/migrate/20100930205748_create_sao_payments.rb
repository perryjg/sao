class CreateSaoPayments < ActiveRecord::Migration
  def self.up
    create_table :sao_payments do |t|
      t.string :fiscal_year, :limit => 4
      t.string :period, :limit => 2
      t.string :agency_code, :limit => 5
      t.string :agency_name
      t.string :vendor_name
      t.string :ap_voucher, :limit => 8
      t.string :account_no, :limit => 6
      t.string :account_name
      t.string :transaction_date
      t.string :class_code, :limit => 5
      t.string :class_description
      t.string :funding_source, :limit => 5
      t.string :fund_source_description
      t.string :program_code, :limit => 10
      t.string :program_description
      t.string :item_description
      t.decimal :amount, :precision => 25, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :sao_payments
  end
end
