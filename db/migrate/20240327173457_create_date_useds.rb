class CreateDateUseds < ActiveRecord::Migration[7.1]
  def change
    create_table :date_useds do |t|
      t.date :present_day
      t.date :last_day
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
