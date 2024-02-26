class CreateCartSaveds < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_saveds do |t|
      t.integer :quantity
      t.boolean :abandoned, default: true
      t.string :code_cart
      t.references :item, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
