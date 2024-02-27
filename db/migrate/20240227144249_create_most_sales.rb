class CreateMostSales < ActiveRecord::Migration[7.1]
  def change
    create_table :most_sales do |t|
      t.integer :quantity
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
