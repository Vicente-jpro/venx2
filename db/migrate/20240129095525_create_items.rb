class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :description
      t.date :manufacturing_date
      t.date :expiration_date
      t.integer :quantity
      t.decimal :price
      t.string :item_code
      t.decimal :profite_value
      t.references :supplier, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.references :sector, null: false, foreign_key: true

      t.timestamps
    end
  end
end
