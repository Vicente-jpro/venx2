class CreateCartTemps < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_temps do |t|
      t.integer :quantity
      t.boolean :abandoned, default: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
