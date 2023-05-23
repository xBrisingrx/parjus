class CreateTablesPoliticalParties < ActiveRecord::Migration[5.2]
  def change
    create_table :tables_political_parties do |t|
      t.references :table, foreign_key: true
      t.references :political_party, foreign_key: true
      t.boolean :active,default: true

      t.timestamps
    end
  end
end
