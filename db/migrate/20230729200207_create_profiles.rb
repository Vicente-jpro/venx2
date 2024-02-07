class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name_profile
      t.string :whatsapp
      t.string :telephone
      t.string :identity_card
      t.string :profile_type
      t.references :user, null: false, foreign_key: true
    
      t.timestamps
    end
  end
end
