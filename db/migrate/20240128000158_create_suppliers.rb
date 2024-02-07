class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name_supplier
      t.string :whatsapp
      t.string :telephone
      t.string :email
      t.references :address, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true


      t.timestamps
    end
  end
end
