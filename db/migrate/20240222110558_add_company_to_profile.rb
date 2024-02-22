class AddCompanyToProfile < ActiveRecord::Migration[7.1]
  def change
    add_reference :profiles, :company, null: false, foreign_key: true, default: 1
  end
end
