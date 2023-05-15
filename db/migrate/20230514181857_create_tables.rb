class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :vouters
      t.boolean :active, default: true
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
