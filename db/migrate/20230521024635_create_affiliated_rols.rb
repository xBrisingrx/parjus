class CreateAffiliatedRols < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliated_rols do |t|
      t.string :name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
