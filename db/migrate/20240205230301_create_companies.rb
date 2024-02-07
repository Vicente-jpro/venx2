class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :whatsapp
      t.string :telephone
      t.string :email
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
