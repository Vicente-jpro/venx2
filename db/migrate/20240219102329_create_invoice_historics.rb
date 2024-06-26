class CreateInvoiceHistorics < ActiveRecord::Migration[7.1]
  def change
    create_table :invoice_historics do |t|
      t.string :cliente_name
      t.decimal :total
      t.decimal :sub_total
      t.decimal :value_delivered_customer
      t.decimal :customer_change
      t.string :payment_method
      t.references :profile, null: false, foreign_key: true
      t.references :cart_historic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
