class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :table, foreign_key: true
      t.references :political_party, foreign_key: true
      t.integer :number, null:false
      t.timestamps
    end
  end
end
