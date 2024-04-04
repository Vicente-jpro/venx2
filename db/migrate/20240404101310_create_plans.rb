class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.date :sign_date
      t.date :expiration_date
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
