class CreateDateUseds < ActiveRecord::Migration[7.1]
  def change
    create_table :date_useds do |t|
      t.time :present_day, default: Time.now
      t.time :last_day, default: Time.now
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
