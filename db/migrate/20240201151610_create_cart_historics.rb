class CreateCartHistorics < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_historics do |t|
      t.integer :quantity
      t.boolean :abandoned, default: false
      t.string :code_cart
      t.references :profile, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
