class CreatePoliticiansParties < ActiveRecord::Migration[5.2]
  def change
    create_table :politicians_parties do |t|
      t.string :politician, null: false
      t.references :political_party, foreign_key: true
      t.references :politician_rol, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
