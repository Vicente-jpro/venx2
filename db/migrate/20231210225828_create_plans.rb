class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name_plans
      t.integer :price, default: 0
      t.text :description

      t.timestamps
    end
  end
end
